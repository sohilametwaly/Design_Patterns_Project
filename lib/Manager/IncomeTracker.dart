import 'package:design_patterns_project/Classes/singleton/Database.dart';

class Incometracker {
  Database database = Database.getInstance();

  Future<Map<String, dynamic>> getWeeklyReport() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    final report = await generateIncomeReport("Weekly", startOfWeek, endOfWeek);
    // print("Labels (Days of the week): ${report['labels']}");
    // print("Data Sales (Income): ${report['dataSales']}");
    return report;
  }

  Future<Map<String, dynamic>> getMonthlyReport() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    final report =
        await generateIncomeReport("Monthly", startOfMonth, endOfMonth);
    return report;
  }

  Future<Map<String, dynamic>> getAnnualReport() async {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year, 12, 31);
    final report = await generateIncomeReport("Annual", startOfYear, endOfYear);
    // print("Labels (Months): ${report['labels']}");
    // print("Data Sales (Income): ${report['dataSales']}");
    return report;
  }

  Future<List<Map<String, dynamic>>> fetchResidentsByDateRange(
      DateTime startDate, DateTime endDate) async {
    final snapshot = await database.readData('bookings');

    if (snapshot != null && snapshot is Map<dynamic, dynamic>) {
      return snapshot.entries
          .map((entry) {
            final booking = Map<String, dynamic>.from(entry.value as Map);

            final total = booking['Total'] as int? ?? 0;
            final checkInDate = booking['checkInDate'] as String?;
            final checkOutDate = booking['checkOutDate'] as String?;

            if (checkInDate != null && checkOutDate != null) {
              return {
                "checkInDate":
                    DateTime.parse(checkInDate).millisecondsSinceEpoch,
                "checkOutDate":
                    DateTime.parse(checkOutDate).millisecondsSinceEpoch,
                "total": total,
              };
            }
            return null; // Skip invalid entries
          })
          .whereType<Map<String, dynamic>>()
          .toList();
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> generateIncomeReport(
      String reportType, DateTime startDate, DateTime endDate) async {
    try {
      final startTimestamp = startDate.millisecondsSinceEpoch ~/ 1000;
      final endTimestamp = endDate.millisecondsSinceEpoch ~/ 1000;

      final residents = await fetchResidentsByDateRange(startDate, endDate);
      double totalIncome = 0;
      List<String> labels = [];
      List<double> dataSales = [];

      if (reportType == "Weekly") {
        labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        dataSales = List.filled(7, 0.0); // Initialize for 7 days of the week

        for (var resident in residents) {
          final checkInDate =
              DateTime.fromMillisecondsSinceEpoch(resident["checkInDate"]);
          final checkOutDate =
              DateTime.fromMillisecondsSinceEpoch(resident["checkOutDate"]);
          final totalCost = resident["total"] ?? 0;

          // Determine the weekday index
          final startDayOfWeek = checkInDate.weekday -
              1; // Convert to 0-based index (0: Monday, 6: Sunday)
          final endDayOfWeek = checkOutDate.weekday - 1;

          if (checkInDate.isBefore(endDate) &&
              checkOutDate.isAfter(startDate)) {
            // Add the income for the relevant days
            for (int i = startDayOfWeek; i <= endDayOfWeek; i++) {
              dataSales[i] +=
                  totalCost / (checkOutDate.difference(checkInDate).inDays + 1);
            }
          }
        }
      } else if (reportType == "Monthly") {
        labels = List.generate(endDate.day, (index) => (index + 1).toString());
        dataSales = List.filled(endDate.day, 0.0);

        for (var resident in residents) {
          final checkInDate =
              DateTime.fromMillisecondsSinceEpoch(resident["checkInDate"]);
          final checkOutDate =
              DateTime.fromMillisecondsSinceEpoch(resident["checkOutDate"]);
          final totalCost = resident["total"] ?? 0;

          if (checkInDate.isBefore(endDate) &&
              checkOutDate.isAfter(startDate)) {
            final startDayOfMonth = checkInDate.day - 1;
            final endDayOfMonth = checkOutDate.day - 1;

            for (int i = startDayOfMonth; i <= endDayOfMonth; i++) {
              dataSales[i] +=
                  totalCost / (checkOutDate.difference(checkInDate).inDays + 1);
            }
          }
        }
      } else if (reportType == "Annual") {
        labels = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];
        dataSales = List.filled(12, 0.0);

        for (var resident in residents) {
          final checkInDate =
              DateTime.fromMillisecondsSinceEpoch(resident["checkInDate"]);
          final checkOutDate =
              DateTime.fromMillisecondsSinceEpoch(resident["checkOutDate"]);
          final totalCost = resident["total"] ?? 0;

          if (checkInDate.isBefore(endDate) &&
              checkOutDate.isAfter(startDate)) {
            final startMonth = checkInDate.month - 1; // 0-based month index
            final endMonth = checkOutDate.month - 1;

            for (int i = startMonth; i <= endMonth; i++) {
              dataSales[i] +=
                  totalCost / (checkOutDate.difference(checkInDate).inDays + 1);
            }
          }
        }
      }

      return {
        'labels': labels,
        'dataSales': dataSales,
      };
    } catch (e) {
      print("Error generating $reportType income report: $e");
      return {'labels': [], 'dataSales': []};
    }
  }
}

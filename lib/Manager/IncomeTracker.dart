import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/calc-cost/Booking.dart';

class Incometracker {
  Database database = Database.getInstance();
  void getWeeklyReport() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    await generateIncomeReport("Weekly", startOfWeek, endOfWeek);
  }

  void getMonthlyReport() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    await generateIncomeReport("Monthly", startOfMonth, endOfMonth);
  }

  void getAnnualReport() async {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year, 12, 31);
    await generateIncomeReport("Annual", startOfYear, endOfYear);
  }

  // Future<List<Map<String, dynamic>>> fetchResidentsByDateRange(
  //     DateTime startDate, DateTime endDate) async {
  //   Database database = Database.getInstance();

  //   final snapshot = await database.readData('bookings');

  //   if (snapshot.value != null) {
  //     return (snapshot.value as Map).entries.map((entry) {
  //       return {
  //         "checkInDate": entry.value['id']['checkInDate'],
  //         "checkOutDate": entry.value['id']['checkOutDate'],
  //         "total": entry.value['id']['Total'],
  //       };
  //     }).toList();
  //   } else {
  //     return [];
  //   }
  // }
  Future<List<Map<String, dynamic>>> fetchResidentsByDateRange(
      DateTime startDate, DateTime endDate) async {
    final snapshot = await database.readData('bookings');

    // Validate snapshot and cast it to a Map
    if (snapshot != null && snapshot is Map<dynamic, dynamic>) {
      return snapshot.entries
          .map((entry) {
            // Safely cast the entry value to Map<String, dynamic>
            final booking = Map<String, dynamic>.from(entry.value as Map);

            // Extract the required fields at the root level
            final total = booking['Total'] as int? ?? 0; // Default to 0 if null
            final checkInDate = booking['checkInDate'] as String?;
            final checkOutDate = booking['checkOutDate'] as String?;

            // Ensure dates are present and valid
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
          .whereType<Map<String, dynamic>>() // Remove null entries
          .toList();
    } else {
      return [];
    }
  }

//   Future<void> generateIncomeReport(
//       String reportType, DateTime startDate, DateTime endDate) async {
//     try {
//       final startTimestamp = startDate.millisecondsSinceEpoch ~/ 1000;
//       final endTimestamp = endDate.millisecondsSinceEpoch ~/ 1000;
//       final residents = await fetchResidentsByDateRange(startDate, endDate);
//       double totalIncome = 0;
//       for (var resident in residents) {
//         final checkInTimestamp = resident['id']["checkInDate"] as int;
//         final checkOutTimestamp = resident['id']["checkOutDate"] as int;
//         final TotalCost = resident['id']["total"] as int;

//         final stayStart = DateTime.fromMillisecondsSinceEpoch(
//                 (checkInTimestamp > startTimestamp
//                         ? checkInTimestamp
//                         : startTimestamp) *
//                     1000)
//             .toUtc();
//         final stayEnd = DateTime.fromMillisecondsSinceEpoch(
//                 (checkOutTimestamp < endTimestamp
//                         ? checkOutTimestamp
//                         : endTimestamp) *
//                     1000)
//             .toUtc();

//         if (!stayEnd.isBefore(stayStart)) {
//           final stayDuration = stayEnd.difference(stayStart).inDays;
//           totalIncome += TotalCost;
//         }
//       }
//     } catch (e) {
//       print("Error generating $reportType income report: $e");
//     }
//   }
// }
  Future<void> generateIncomeReport(
      String reportType, DateTime startDate, DateTime endDate) async {
    try {
      final startTimestamp = startDate.millisecondsSinceEpoch ~/ 1000;
      final endTimestamp = endDate.millisecondsSinceEpoch ~/ 1000;

      // Fetch data within the date range
      final residents = await fetchResidentsByDateRange(startDate, endDate);
      double totalIncome = 0;
      print(residents.length);

      for (var resident in residents) {
        // Parse timestamps
        final checkInTimestamp = resident["checkInDate"] ?? 0;
        final checkOutTimestamp = resident["checkOutDate"] ?? 0;
        final totalCost = resident["total"] ?? 0;
        print('total cost $totalCost');

        totalIncome += totalCost;

        // Validate timestamps
        // final stayStart = DateTime.fromMillisecondsSinceEpoch(
        //         (checkInTimestamp > startTimestamp
        //                 ? checkInTimestamp
        //                 : startTimestamp) *
        //             1000)
        //     .toUtc();
        // final stayEnd = DateTime.fromMillisecondsSinceEpoch(
        //         (checkOutTimestamp < endTimestamp
        //                 ? checkOutTimestamp
        //                 : endTimestamp) *
        //             1000)
        //     .toUtc();

        // if (!stayEnd.isBefore(stayStart)) {
        //   totalIncome += totalCost;
        // }
      }

      print(
          "$reportType income report generated successfully: Total Income = $totalIncome");
    } catch (e) {
      print("Error generating $reportType income report: $e");
    }
  }
}

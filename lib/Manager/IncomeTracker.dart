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

  Future<List<Map<String, dynamic>>> fetchResidentsByDateRange(
      DateTime startDate, DateTime endDate) async {
    Database database = Database.getInstance();

    final snapshot = await database.readData('bookings');

    if (snapshot.value != null) {
      return (snapshot.value as Map).entries.map((entry) {
        return {
          "checkIn": entry.value['checkIn'],
          "checkOut": entry.value['checkOut'],
          "totalCost": entry.value['TotalCost'],
        };
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> generateIncomeReport(
      String reportType, DateTime startDate, DateTime endDate) async {
    try {
      final startTimestamp = startDate.millisecondsSinceEpoch ~/ 1000;
      final endTimestamp = endDate.millisecondsSinceEpoch ~/ 1000;
      final residents = await fetchResidentsByDateRange(startDate, endDate);
      double totalIncome = 0;
      for (var resident in residents) {
        final checkInTimestamp = resident["checkInTimestamp"] as int;
        final checkOutTimestamp = resident["checkOutTimestamp"] as int;
        final TotalCost = resident["TotalCost"] as int;

        final stayStart = DateTime.fromMillisecondsSinceEpoch(
                (checkInTimestamp > startTimestamp
                        ? checkInTimestamp
                        : startTimestamp) *
                    1000)
            .toUtc();
        final stayEnd = DateTime.fromMillisecondsSinceEpoch(
                (checkOutTimestamp < endTimestamp
                        ? checkOutTimestamp
                        : endTimestamp) *
                    1000)
            .toUtc();

        if (!stayEnd.isBefore(stayStart)) {
          final stayDuration = stayEnd.difference(stayStart).inDays + 1;
          totalIncome += TotalCost;
        }
      }
    } catch (e) {
      print("Error generating $reportType income report: $e");
    }
  }
}

import 'package:design_patterns_project/Classes/singleton/Database.dart';
import 'package:design_patterns_project/Classes/Manager/RoomMonitoring.dart';

class Roommonitor implements Roommonitoring {
  final _db = Database.getInstance();

  @override
  Future<Map<String, Map<String, dynamic>>> monitorRooms() async {
    final Map<String, dynamic> rawData = await _db.readData("Rooms");
    final Map<String, Map<String, dynamic>> transformedData =
        rawData.map((key, value) {
      return MapEntry(key, Map<String, dynamic>.from(value));
    });
    return transformedData;
  }
}

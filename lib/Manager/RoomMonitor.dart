import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/Manager/RoomMonitoring.dart';

class Roommonitor implements Roommonitoring {
  final _db = Database.getInstance();
  @override
  Future<Map<String, Map<String, dynamic>>> monitorRooms() async {
    return await _db.readData("rooms");
  }
}

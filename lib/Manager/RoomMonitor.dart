import 'package:design_patterns_project/Manager/RoomMonitoring.dart';

class Roommonitor implements Roommonitoring {
  @override
  Map<String, Map<String, dynamic>> monitorRooms() {
    return Database.getInstance().read("rooms");
  }
}

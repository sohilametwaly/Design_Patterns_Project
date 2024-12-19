
import 'package:design_patterns_project/abstract_room.dart';
import 'package:design_patterns_project/room_factory.dart';
import 'package:design_patterns_project/user.dart';
import 'Resident.dart';
import 'ResidentManagement.dart';

class Receptionist extends User {
  final ResidentManagement _residentManagement = ResidentManagement();
  final Map<Resident, AbstractRoom> _listOfAssignedRooms = {};
  final Resident resident=Resident();
  Receptionist(super.username, super.password, super.role);

  void assignRoom(int roomNum, String roomType, Resident resident) {
    if (_listOfAssignedRooms.containsKey(resident)) {
      print("Resident ${resident.getName()} is already assigned to a room.");
    } else {
      try {
        AbstractRoom room = RoomFactory.createRoom(roomType, roomNum);
        _listOfAssignedRooms[resident] = room;
        print("Assigned ${resident.getName()} to room number $roomNum.");
      } catch (e) {
        print("Error assigning room: $e");
      }
    }
  }
}

import 'package:design_patterns_project/user.dart';

import 'Resident.dart';
import 'ResidentManagement.dart';

class Receptionist  extends User{
  final ResidentManagement _residentManagement = ResidentManagement();

  Receptionist(super.username, super.password, super.role);
  // final Map<Resident, Room> _listOfResidents = {};

  void assignRoom(int roomNum, String roomType, bool availability, Resident resident) {
    // if (_listOfResidents.containsKey(resident)) {
    //   print("Resident ${resident.getName()} is already assigned to a room.");
    // } else {
    //   final room = Room(roomNum, roomType, availability);
    //   _listOfResidents[resident] = room;
    //   print("Assigned ${resident.getName()} to $room");
    // }
  }
}
//import 'package:design_patterns_project/abstract_room.dart';
//import 'package:design_patterns_project/user.dart';
import 'Resident.dart';
import 'ResidentManagement.dart';
import 'package:design_patterns_project/roomAssigner.dart';

class Receptionist  {
  final ResidentManagement residentManagement;
  //final Map<Resident, AbstractRoom> _listOfAssignedRooms = {};
 // final Resident resident=Resident();
  final RoomAssigner roomAssigner;
  Receptionist(
    // super.username, super.password, super.role,
   this.residentManagement, this.roomAssigner);

//   void addResident(Resident resident, String desiredRoomType) async {
//   final roomDetails = await roomAssigner.assignRoom(resident, desiredRoomType);

//   if (roomDetails != null) {
//     this.residentManagement.addResident(resident);
//     //print("Resident ${resident.name} assigned to room ${roomDetails['roomId']} and added successfully.");
//   } else {
//     print("Failed to assign room for resident ${resident.name}. No matching room available.");
//   }
// }

  Future<Map<String, dynamic>?> assignRoom(Resident resident, String desiredRoomType){
    return this.roomAssigner.assignRoom(resident, desiredRoomType);
  }
  
  void addResident(Resident resident) {
    //roomAssigner.assignRoom(resident, desiredRoomType);
    this.residentManagement.addResident(resident);
    
    //print("added in receptionist");
    
  }

  void editResident(String id, Resident newResident) {
    this.residentManagement.editResident(id , newResident);
  }

  void deleteResident(String id) {
    this.residentManagement.deleteResident(id);
  }

  Future<Map<String, Map<String, dynamic>>> viewResidents() {
    return this.residentManagement.viewResidents();
  }



  // void assignRoom(int roomNum, String roomType, Resident resident) {
  //   if (_listOfAssignedRooms.containsKey(resident)) {
  //     print("Resident ${resident.getName()} is already assigned to a room.");
  //   } else {
  //     try {
  //       AbstractRoom room = RoomFactory.createRoom(roomType, roomNum);
  //       _listOfAssignedRooms[resident] = room;
  //       print("Assigned ${resident.getName()} to room number $roomNum.");
  //     } catch (e) {
  //       print("Error assigning room: $e");
  //     }
  //   }
  // }
}

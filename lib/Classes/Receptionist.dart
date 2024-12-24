import 'Resident.dart';
import 'ResidentManagement.dart';
import 'package:design_patterns_project/Classes/roomAssigner.dart';

class Receptionist {
  final ResidentManagement residentManagement;

  final RoomAssigner roomAssigner;
  Receptionist(
      // super.username, super.password, super.role,
      this.residentManagement,
      this.roomAssigner);

  Future<Map<String, dynamic>?> assignRoom(
      Resident resident, String desiredRoomType) {
    return this.roomAssigner.assignRoom(resident, desiredRoomType);
  }

  void addResident(Resident resident) {
    //roomAssigner.assignRoom(resident, desiredRoomType);
    this.residentManagement.addResident(resident);
  }

  void editResident(String id, Resident newResident) {
    this.residentManagement.editResident(id, newResident);
  }

  void deleteResident(String id) {
    this.residentManagement.deleteResident(id);
  }

  Future<Map<String, Map<String, dynamic>>> viewResidents() {
    return this.residentManagement.viewResidents();
  }
}


import 'Resident.dart';

class ResidentManagement {
  final Map<int, Resident> _listOfResidents = {};

  void addResident(Resident resident) {
    _listOfResidents[resident.getId()!] = resident;
    // Insert Resident into database
  }

  void editResident(Resident newResident, int id) {
    final currentResident = _listOfResidents[id];
    if (currentResident != null) {
      currentResident.setName(newResident.getName()!);
      currentResident.setEmail(newResident.getEmail()!);
      currentResident.setPhone(newResident.getPhone()!);
      // Edit in the database
    }
  }

  void deleteResident(int id) {
    _listOfResidents.remove(id);
    // Remove from the database
  }
}

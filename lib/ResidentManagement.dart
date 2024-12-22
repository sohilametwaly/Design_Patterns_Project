import 'Resident.dart';

class ResidentManagement {
  static final Map<String, Resident> listOfResidents = {};

  void addResident(Resident resident) {
    listOfResidents[resident.getId()!] = resident;
    // Insert Resident into database
  }

  void editResident(Resident newResident, String id) {
    final currentResident = listOfResidents[id];
    if (currentResident != null) {
      currentResident.setName(newResident.getName()!);
      currentResident.setEmail(newResident.getEmail()!);
      currentResident.setPhone(newResident.getPhone()!);
      // Edit in the database
    }
  }

  void deleteResident(String id) {
    listOfResidents.remove(id);
    // Remove from the database
  }
}

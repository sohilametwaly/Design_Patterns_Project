import 'package:design_patterns_project/Classes/singleton/Database.dart';
import 'Resident.dart';

class ResidentManagement {
  final Database _db = Database.getInstance();

  void addResident(Resident resident) async {
    await _db.writeData('residents/${resident.id}', resident.toMap());

    await _db.writeData('bookings/${resident.id}', resident.booking.toMap());
    print("added in resident management");
  }

  void editResident(String id, Resident newResident) async {
    await _db.updateData('residents/$id', newResident.toMap());

    await _db.updateData(
        'bookings/${newResident.id}', newResident.toMap()['booking']);
  }

  void deleteResident(String id) async {
    await _db.deleteData('residents/$id');
  }

  Future<Map<String, Map<String, dynamic>>> viewResidents() async {
    final Map<dynamic, dynamic> rawData = await _db.readData("residents");
    final Map<String, Map<String, dynamic>> residentsMap = {};

    // Convert Map<dynamic, dynamic> to Map<String, Map<String, dynamic>>
    rawData.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        residentsMap[key.toString()] = Map<String, dynamic>.from(value);
      } else {
        throw TypeError();
      }
    });

    return residentsMap;
  }
}
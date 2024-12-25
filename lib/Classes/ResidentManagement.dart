import 'package:design_patterns_project/Classes/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Classes/singleton/Database.dart';
import 'Resident.dart';

class ResidentManagement {
  final Database _db = Database.getInstance();
  final Residentviewer _residentviewer = Residentviewer();

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
    final Future<Map<String, Map<String, dynamic>>> residentsMap =
        _residentviewer.viewResidents();

    return residentsMap;
  }
}

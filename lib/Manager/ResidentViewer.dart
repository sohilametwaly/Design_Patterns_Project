import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/Manager/ResidentViewing.dart';

class Residentviewer implements Residentviewing {
  final _db = Database.getInstance();
  @override
  Future<Map<String, Map<String, dynamic>>> viewResidents() async {
    return await _db.readData("residents");
  }
}

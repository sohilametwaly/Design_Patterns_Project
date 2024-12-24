import 'package:design_patterns_project/Classes/singleton/Database.dart';
import 'package:design_patterns_project/Classes/Manager/ResidentViewing.dart';

class Residentviewer implements Residentviewing {
  final _db = Database.getInstance();
  @override
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

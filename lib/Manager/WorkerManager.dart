import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/worker.dart';


class WorkerManager {
  final Database _db = Database.getInstance();

  void addWorker(Worker worker) async {
    await _db.writeData('workers/${worker.id}', worker.toMap());
  }

  void editWorker(String id, Worker newWorker) async {
    await _db.writeData('workers/$id', newWorker.toMap());
  }

  void deleteWorker(String id) async {
    await _db.deleteData('workers/$id');
  }

  Future<Map<String, Map<String, dynamic>>> viewWorkers() async {

    final Map<dynamic, dynamic> rawData = await _db.readData("workers");
    final Map<String, Map<String, dynamic>> workersMap = {};
    // Convert Map<dynamic, dynamic> to Map<String, Map<String, dynamic>>
     rawData.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
         Map<String, dynamic> workerMap = Map<String, dynamic>.from(value);

        if (workerMap.containsKey('salary')) {
          if (workerMap['salary'] is int) {
            workerMap['salary'] = (workerMap['salary'] as int).toDouble();
          }
        }
        workersMap[key.toString()] = workerMap;
      } else {
        throw TypeError(); 
      }
    });
    return workersMap;
  }
}


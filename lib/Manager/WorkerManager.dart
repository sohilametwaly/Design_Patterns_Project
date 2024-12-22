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
    return _db.readData("workers");
  }
}

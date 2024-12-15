import 'package:design_patterns_project/Database.dart';

class WorkerManager {
  final Database _db = Database.getInstance();

  void addWorker(Worker worker) async {
    await _db.writeData('workers/${worker.id}', worker);
  }

  void editWorker(String id, Worker newWorker) async {
    await _db.writeData('workers/$id', newWorker);
  }

  void deleteWorker(String id) async {
    await _db.deleteData('workers/$id');
  }

  Future<Map<String, Map<String, dynamic>>> viewWorkers() async {
    return _db.readData("workers");
  }
}

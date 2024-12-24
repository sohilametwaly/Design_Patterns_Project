import 'package:design_patterns_project/Classes/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Classes/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Classes/Manager/RoomMonitor.dart';
import 'package:design_patterns_project/Classes/Manager/WorkerManager.dart';
import 'package:design_patterns_project/Classes/worker.dart';

class Manager {
  final WorkerManager workerManager;
  final Incometracker incomeTracker;
  final Roommonitor roomMonitor;
  final Residentviewer residentViewer;

  Manager(
      {required this.workerManager,
      required this.incomeTracker,
      required this.roomMonitor,
      required this.residentViewer});

  Future<void> addWorker(Worker worker) async {
    await this.workerManager.addWorker(worker);
  }

  Future<void> editWorker(String id, Worker newWorker) async {
    await this.workerManager.editWorker(id, newWorker);
  }

  Future<void> deleteWorker(String id) async {
    await this.workerManager.deleteWorker(id);
  }

  // Workers Details
  Future<Map<String, Map<String, dynamic>>> viewWorkers() {
    return this.workerManager.viewWorkers();
  }

  // Room Monitoring
  void monitorRooms() {
    this.roomMonitor.monitorRooms();
  }

  // Income Tracking
  Future<Map<String, dynamic>> getWeeklyReport() {
    return this.incomeTracker.getWeeklyReport();
  }

  Future<Map<String, dynamic>> getMonthlyReport() {
    return this.incomeTracker.getMonthlyReport();
  }

  Future<Map<String, dynamic>> getAnnualReport() {
    return this.incomeTracker.getAnnualReport();
  }

  Future<Map<String, Map<String, dynamic>>> viewResidents() {
    return this.residentViewer.viewResidents();
  }
}

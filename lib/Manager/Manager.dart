import 'package:design_patterns_project/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Manager/RoomMonitoring.dart';
import 'package:design_patterns_project/Manager/WorkerManager.dart';
import 'package:design_patterns_project/worker.dart';

class Manager {
  final WorkerManager workerManager;
  final Incometracker incomeTracker;
  final Roommonitoring roomMonitor;
  final Residentviewer residentViewer;

  Manager(
      {required this.workerManager,
      required this.incomeTracker,
      required this.roomMonitor,
      required this.residentViewer});

  void addWorker(Worker worker) {
    this.workerManager.addWorker(worker);
  }

  void editWorker(String id, Worker newWorker) {
    this.workerManager.editWorker(id, newWorker);
  }

  void deleteWorker(String id) {
    this.workerManager.deleteWorker(id);
  }

  // Workers Details
  void viewWorkers() {
    this.workerManager.viewWorkers();
  }

  // Room Monitoring
  void monitorRooms() {
    this.roomMonitor.monitorRooms();
  }

  // Income Tracking
  void getWeeklyReport() {
    this.incomeTracker.generateWeeklyReport();
  }

  void getMonthlyReport() {
    this.incomeTracker.generateMonthlyReport();
  }

  void getAnnualReport() {
    this.incomeTracker.generateAnnualReport();
  }
}

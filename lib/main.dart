import 'package:flutter/material.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/Manager/WorkerManager.dart';
import 'package:design_patterns_project/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Manager/RoomMonitor.dart';
import 'package:design_patterns_project/workerList.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WorkerManager workerManager = WorkerManager();
    Incometracker incometracker = Incometracker();
    Roommonitor roommonitor = Roommonitor();
    Residentviewer residentviewer = Residentviewer();
    Manager manager = Manager(
      workerManager: workerManager,
      incomeTracker: incometracker,
      roomMonitor: roommonitor,
      residentViewer: residentviewer
      );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Firebase Sign Up',
      home: WorkerListPage(manager: manager),
    );
  }
}




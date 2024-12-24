import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_patterns_project/Classes/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Classes/Manager/Manager.dart';
import 'package:design_patterns_project/Classes/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Classes/Manager/RoomMonitor.dart';
import 'package:design_patterns_project/pages/reports.dart';
import 'package:design_patterns_project/Classes/Receptionist.dart';
import 'package:design_patterns_project/Classes/ResidentManagement.dart';
import 'package:design_patterns_project/pages/resident_list/residentList.dart';
import 'package:design_patterns_project/Classes/roomAssigner.dart';
import 'package:design_patterns_project/pages/signup/signuppage.dart';
import 'package:flutter/material.dart';
import 'pages/login/loginpage.dart';

import 'Classes/Manager/WorkerManager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // WorkerManager workerManager = WorkerManager();
    // Incometracker incometracker = Incometracker();
    // Roommonitor roommonitor = Roommonitor();
    // Residentviewer residentviewer = Residentviewer();
    // Manager manager = Manager(
    //     workerManager: workerManager,
    //     incomeTracker: incometracker,
    //     roomMonitor: roommonitor,
    //     residentViewer: residentviewer);
    ResidentManagement residentManagement = ResidentManagement();
    RoomAssigner roomAssigner = RoomAssigner();
    Receptionist receptionist = Receptionist(residentManagement, roomAssigner);
    WorkerManager workerManager = WorkerManager();
    Incometracker incometracker = Incometracker();
    Roommonitor roommonitor = Roommonitor();
    Residentviewer residentViewer = Residentviewer();

    Manager m = Manager(
        workerManager: workerManager,
        incomeTracker: incometracker,
        roomMonitor: roommonitor,
        residentViewer: residentViewer);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Firebase Sign Up',
      home: ResidentListPage(receptionist: receptionist),
    );
  }
}

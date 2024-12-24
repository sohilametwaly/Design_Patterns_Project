import 'package:design_patterns_project/Classes/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Classes/Manager/Manager.dart';
import 'package:design_patterns_project/Classes/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Classes/Manager/RoomMonitor.dart';

import 'package:design_patterns_project/Classes/Receptionist.dart';
import 'package:design_patterns_project/Classes/ResidentManagement.dart';

import 'package:design_patterns_project/Classes/roomAssigner.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/login/loginpage.dart';

import 'Classes/Manager/WorkerManager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: LoginPage(),
    );
  }
}

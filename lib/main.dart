import 'package:design_patterns_project/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Manager/RoomMonitor.dart';
import 'package:design_patterns_project/Manager/RoomMonitoring.dart';
import 'package:design_patterns_project/Room_list_screen.dart';
import 'package:design_patterns_project/resident_list/ResidentListScreen.dart';
import 'package:design_patterns_project/resident_list/addResident.dart';

import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/signup/signuppage.dart';

import 'package:flutter/material.dart';
// import 'package:design_patterns_project/Manager/Manager.dart';
// import 'package:design_patterns_project/Manager/WorkerManager.dart';
// import 'package:design_patterns_project/Manager/IncomeTracker.dart';
// import 'package:design_patterns_project/Manager/ResidentViewer.dart';
// import 'package:design_patterns_project/Manager/RoomMonitor.dart';
// import 'package:design_patterns_project/workerList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Receptionist.dart';
import 'roomAssigner.dart';
import 'ResidentManagement.dart';
import 'residentList.dart';

import 'package:design_patterns_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'login/loginpage.dart';

import 'Manager/WorkerManager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerManager workerManager = WorkerManager();
    Incometracker incometracker = Incometracker();
    Roommonitor roommonitor = Roommonitor();
    Residentviewer residentViewer = Residentviewer();
    Manager m = Manager(
        workerManager: workerManager,
        incomeTracker: incometracker,
        roomMonitor: roommonitor,
        residentViewer: residentViewer);
    // final Roommonitoring roomMonitor;
    // final Residentviewer residentViewer;
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        //title: 'Firebase Sign Up',
        home: SignUpPage());
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_patterns_project/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Manager/RoomMonitor.dart';
import 'package:design_patterns_project/Manager/RoomMonitoring.dart';
import 'package:design_patterns_project/Room_list_screen.dart';
import 'package:design_patterns_project/residentDetails.dart';
import 'package:design_patterns_project/resident_list/ResidentListScreen.dart';
import 'package:design_patterns_project/resident_list/addResident.dart';

import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/worker-list.dart';

import 'package:flutter/material.dart';

import 'Manager/WorkerManager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});




  @override
  Widget build(BuildContext context) {
     WorkerManager workerManager= WorkerManager();
     Incometracker incometracker= Incometracker();
     Roommonitor roommonitor=Roommonitor();
     Residentviewer residentViewer = Residentviewer();
    Manager m = Manager(workerManager: workerManager, incomeTracker: incometracker, roomMonitor:roommonitor, residentViewer: residentViewer);
     // final Roommonitoring roomMonitor;
    // final Residentviewer residentViewer;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: RoomListScreen(manager: m),
      home: RoomListScreen(manager: m)
    );
  }
}





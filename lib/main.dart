import 'package:design_patterns_project/resident_list/ResidentListScreen.dart';
import 'package:design_patterns_project/resident_list/addResident.dart';

import 'package:design_patterns_project/Database.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // WorkerManager workerManager = WorkerManager();
    // Incometracker incometracker = Incometracker();
    // Roommonitor roommonitor = Roommonitor();
    // Residentviewer residentviewer = Residentviewer();
    // Manager manager = Manager(
    //   workerManager: workerManager,
    //   incomeTracker: incometracker,
    //   roomMonitor: roommonitor,
    //   residentViewer: residentviewer
    //   );
    ResidentManagement residentManagement = ResidentManagement();
    RoomAssigner roomAssigner = RoomAssigner();
    Receptionist receptionist = Receptionist(residentManagement, roomAssigner);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddResidentScreen(),
    );
  }
}

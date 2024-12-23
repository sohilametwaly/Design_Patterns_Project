
import 'package:design_patterns_project/Room_list_screen.dart';
import 'package:design_patterns_project/resident_list/ResidentListScreen.dart';
import 'package:design_patterns_project/resident_list/addResident.dart';

import 'package:design_patterns_project/Database.dart';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoomListScreen(),
    );
  }
}





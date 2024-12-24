import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/view-resident.dart';
// import 'package:design_patterns_project/worker-list.dart';

import 'package:flutter/material.dart';
import 'login/loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Firebase Sign Up',
      home: WorkerListPage(manager: m),
    );
  }
}

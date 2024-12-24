import 'package:firebase_core/firebase_core.dart';
// import 'package:design_patterns_project/worker-list.dart';

import 'package:flutter/material.dart';
import 'pages/login/loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Firebase Sign Up',
      home: LoginPage(),
    );
  }
}

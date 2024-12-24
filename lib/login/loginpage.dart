import 'package:design_patterns_project/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Manager/RoomMonitor.dart';
import 'package:design_patterns_project/Manager/WorkerManager.dart';
import 'package:design_patterns_project/Receptionist.dart';
import 'package:design_patterns_project/ResidentManagement.dart';
import 'package:design_patterns_project/forgetPassword.dart';
import 'package:design_patterns_project/navBar.dart';
import 'package:design_patterns_project/residentList.dart';
import 'package:design_patterns_project/roomAssigner.dart';
import 'package:flutter/material.dart';
import 'package:design_patterns_project/proxyauth.dart';
import 'package:design_patterns_project/signup/signuppage.dart';
import 'package:design_patterns_project/Database.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginPage extends StatelessWidget {
  Database database = Database.getInstance();
  final Proxyauth _authProxy = Proxyauth();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Authenticate the user
                  await _authProxy.login(
                      _emailController.text, _passwordController.text);

                  WorkerManager workerManager = WorkerManager();
                  Incometracker incometracker = Incometracker();
                  Roommonitor roommonitor = Roommonitor();
                  Residentviewer residentviewer = Residentviewer();
                  Manager manager = Manager(
                    workerManager: workerManager,
                    incomeTracker: incometracker,
                    roomMonitor: roommonitor,
                    residentViewer: residentviewer,
                  );

                  ResidentManagement residentManagement = ResidentManagement();
                  RoomAssigner roomAssigner = RoomAssigner();
                  Receptionist receptionist =
                      Receptionist(residentManagement, roomAssigner);

                  // Fetch the current user
                  firebase_auth.User? currentUser =
                      firebase_auth.FirebaseAuth.instance.currentUser;

                  if (currentUser != null) {
                    String userId = currentUser.uid;
                    Map<String, dynamic> user =
                        await database.readData('users/$userId');

                    if (user['isManager']) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(
                              isManager: user['isManager'], manager: manager),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResidentListPage(receptionist: receptionist),
                        ),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Successful!')),
                    );
                  } else {
                    throw Exception('No user is currently logged in.');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text("Don't have an account? Sign Up"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to the Login page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Forgetpassword()));
              },
              child: Text("Forget password?"),
            ),
          ],
        ),
      ),
    );
  }
}

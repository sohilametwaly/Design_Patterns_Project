<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======

=======
>>>>>>> 0e12237 (login and signup pages)
=======
>>>>>>> fb495182374fb16bb93eeaf3d79a3e527abcf9c7
import 'package:design_patterns_project/Manager/IncomeTracker.dart';
import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:design_patterns_project/Manager/ResidentViewer.dart';
import 'package:design_patterns_project/Manager/RoomMonitor.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:design_patterns_project/Manager/RoomMonitoring.dart';
import 'package:design_patterns_project/Room_list_screen.dart';
import 'package:design_patterns_project/resident_list/ResidentListScreen.dart';
import 'package:design_patterns_project/resident_list/addResident.dart';

import 'package:design_patterns_project/Database.dart';
<<<<<<< HEAD

>>>>>>> e6054a5 (room-list-done)
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
=======
=======
=======
>>>>>>> fb495182374fb16bb93eeaf3d79a3e527abcf9c7
import 'package:design_patterns_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
>>>>>>> 0e12237 (login and signup pages)
import 'package:flutter/material.dart';
import 'login/loginpage.dart';
>>>>>>> 5c80577 (some edits)

<<<<<<< HEAD
<<<<<<< HEAD
void main() async {
=======
import 'Manager/WorkerManager.dart';

<<<<<<< HEAD
void main() {
>>>>>>> c74ce9a (room list after updates)
=======
Future<void> main() async {
>>>>>>> 0e12237 (login and signup pages)
=======
import 'Manager/WorkerManager.dart';

Future<void> main() async {
>>>>>>> fb495182374fb16bb93eeaf3d79a3e527abcf9c7
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
=======
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

<<<<<<< HEAD
class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
>>>>>>> 5c80577 (some edits)
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
<<<<<<< HEAD
      //title: 'Firebase Sign Up',
      home: ResidentListPage(receptionist: receptionist),
=======
      home: RoomListScreen(),
>>>>>>> e6054a5 (room-list-done)
=======
     WorkerManager workerManager= WorkerManager();
     Incometracker incometracker= Incometracker();
     Roommonitor roommonitor=Roommonitor();
     Residentviewer residentViewer = Residentviewer();
    Manager m = Manager(workerManager: workerManager, incomeTracker: incometracker, roomMonitor:roommonitor, residentViewer: residentViewer);
=======
class MainApp extends StatelessWidget {
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
<<<<<<< HEAD
>>>>>>> 0e12237 (login and signup pages)
=======
>>>>>>> fb495182374fb16bb93eeaf3d79a3e527abcf9c7
    // final Roommonitoring roomMonitor;
    // final Residentviewer residentViewer;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: RoomListScreen(manager: m),
>>>>>>> c74ce9a (room list after updates)
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

<<<<<<< HEAD
=======
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
=======
      title: 'Firebase Sign Up',
      home: LoginPage(),
>>>>>>> 0e12237 (login and signup pages)
    );
  }
}
>>>>>>> 5c80577 (some edits)

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

class Database {
  static final FirebaseDatabase _database = FirebaseDatabase.instance;
}

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

class Database {
  late FirebaseDatabase _firebase;
  late DatabaseReference _ref;
  static final Database _database = Database._();
  bool _isInitialized = false;

  Database._() {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    if (!_isInitialized) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      _firebase = FirebaseDatabase.instance;
      _ref = FirebaseDatabase.instance.ref();
      _isInitialized = true;
    }
  }

  static getInstance() {
    return _database;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _initializeApp();
    }
  }

  writeData(String path, Map<String, dynamic> data) async {
    await _ensureInitialized();
    await _ref.child(path).set(data);
  }

  updateData(String path, Map<String, dynamic> data) async {
    await _ensureInitialized();
    await _ref.child(path).update(data);
  }

  readData(String path) async {
    await _ensureInitialized();
    final snapshot = await _ref.child(path).get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;

      final Map<String, dynamic> mappedData = data.map(
        (key, value) => MapEntry(
          key.toString(),
          value,
        ),
      );
      return mappedData;
    } else {
      return {};
    }
  }

  deleteData(String path) async {
    await _ensureInitialized();
    await _ref.child(path).remove();
  }
}
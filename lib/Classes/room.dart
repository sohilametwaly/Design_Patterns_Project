import 'singleton/Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../firebase_options.dart';

class AbstractRoom {
  String roomNumber;
  bool occupied;
  String roomType;

  AbstractRoom(this.roomNumber, this.roomType, this.occupied);

  Map<String, dynamic> toMap() {
    return {
      'id': roomNumber,
      'occupied': occupied,
      'roomType': roomType,
    };
  }
}

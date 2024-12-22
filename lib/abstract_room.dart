import 'Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

class AbstractRoom {
  int roomNumber;
  double pricePerNight;
  bool occupied = false;
  String roomType;

  AbstractRoom(this.roomNumber, this.pricePerNight, this.roomType);

  // String getRoomType() {
  //   return room_type;
  // }

  double getBaseCost(int nights) {
    return pricePerNight * nights;
  }
}

import 'abstract_room.dart';
import 'single_room.dart';
import 'double_room.dart';
import 'triple_room.dart';


class RoomFactory {
  static AbstractRoom createRoom(String roomType, int roomNumber) {

    if (roomType == "Single") {
      return SingleRoom(roomNumber);
    }else if(roomType == "Double"){
      return DoubleRoom(roomNumber);
    }else if(roomType == "Triple"){
      return TripleRoom(roomNumber);
    }else{
      throw ArgumentError("Invalid Room Type: $roomType");
    }
  }
}
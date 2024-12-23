import 'abstract_room.dart';
import 'single_room.dart';
import 'double_room.dart';
import 'triple_room.dart';
import 'Database.dart';

class RoomFactory {
  static AbstractRoom createRoom(String roomType, int roomNumber) {
  
  static void createRoom(String roomType, int roomNumber) {
     Database database = Database.getInstance();
     Map<String,dynamic> room ={'Room_type':roomType,'Room_number':roomNumber,''}
    //  AbstractRoom? currentRoom =

    //   String userId = currentUser!.uid;

    if (roomType == "Single") {
       database.writeData('Rooms/', data)
    }else if(roomType == "Double"){
       DoubleRoom(roomNumber);
    }else if(roomType == "Triple"){
      return TripleRoom(roomNumber);
    }else{
      throw ArgumentError("Invalid Room Type: $roomType");
    }
  }
}
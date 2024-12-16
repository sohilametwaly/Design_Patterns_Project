import 'abstract_room.dart';

class DoubleRoom extends AbstractRoom{
  DoubleRoom(int roomNumber) : super(roomNumber, 75.0); 

  @override
  String getRoomType() {
    return "Double Room";
  }
}
import 'abstract_room.dart';

class SingleRoom extends AbstractRoom{
  SingleRoom(int roomNumber) : super(roomNumber, 50.0); 

  @override
  String getRoomType() {
    return "Single Room";
  }
}
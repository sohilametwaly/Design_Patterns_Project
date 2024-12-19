import 'abstract_room.dart';

class TripleRoom extends AbstractRoom{
  TripleRoom(int roomNumber) : super(roomNumber, 100.0); 

  @override
  String getRoomType() {
    return "Triple Room";
  }
}
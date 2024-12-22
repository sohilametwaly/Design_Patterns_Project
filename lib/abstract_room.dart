abstract class AbstractRoom {
  int roomNumber;
  double pricePerNight;
  bool occupied;

  AbstractRoom(this.roomNumber, this.pricePerNight) : occupied = false;

  String getRoomType();

  double getBaseCost(int nights) {
    return pricePerNight * nights;
  }
}

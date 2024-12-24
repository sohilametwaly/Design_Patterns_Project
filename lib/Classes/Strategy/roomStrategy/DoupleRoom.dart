import 'package:design_patterns_project/Classes/Strategy/roomStrategy/RoomStrategy.dart';

class DoupleRoom implements Roomstrategy {
  double calculateCost(nights) {
    return nights * 250;
  }
}

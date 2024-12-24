import 'package:design_patterns_project/Classes/Strategy/roomStrategy/RoomStrategy.dart';

class TripleRoom implements Roomstrategy {
  double calculateCost(nights) {
    return nights * 350;
  }
}

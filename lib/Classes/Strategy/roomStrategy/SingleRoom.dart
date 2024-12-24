import 'package:design_patterns_project/Classes/Strategy/roomStrategy/RoomStrategy.dart';

class SingleRoom implements Roomstrategy {
  double calculateCost(int nights) {
    return nights * 150.0;
  }
}

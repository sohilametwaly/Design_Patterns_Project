import 'package:design_patterns_project/RoomStrategy.dart';

class DoupleRoom implements Roomstrategy {
  double calculateCost(nights){
    return nights *  250;
  }
}
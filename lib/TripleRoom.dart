import 'package:design_patterns_project/RoomStrategy.dart';

class TripleRoom implements Roomstrategy {
   double calculateCost(nights){
    return nights *  350;
  }
}
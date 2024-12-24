import 'package:design_patterns_project/Abstract Boarding Option/AbstractBoardingOption.dart';
import 'package:design_patterns_project/RoomStrategy.dart';
import 'package:design_patterns_project/abstract_room.dart';
import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';

class Booking {
  DateTime checkInDate;
  DateTime checkOutDate;
  AbstractRoom room;
  AbstractBoardingOption boardingOption;
  double TotalCost = 0.0;
  CostCalculationStrategy boardingStrategy;
  Roomstrategy roomstrategy;

  Booking(this.checkInDate, this.checkOutDate, this.room, this.boardingOption,
      this.boardingStrategy, this.roomstrategy) {
    if (!checkOutDate.isBefore(checkInDate)) {
      final stayDuration = checkOutDate.difference(checkInDate).inDays;
      calculateTotalCost(stayDuration);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'room': room.toMap(),
      'boarding': boardingOption.toMap(),
      'Total': TotalCost
    };
  }

  calculateTotalCost(int nights) {
    double boardingCost = boardingStrategy.calculateCost(nights);
    double roomCost = roomstrategy.calculateCost(nights);
    TotalCost = (boardingCost + roomCost);
    return TotalCost;
  }

  // void displayDetails() {
  //   print('$DurationOfStay $boardingOption $room $id');
  // }
}

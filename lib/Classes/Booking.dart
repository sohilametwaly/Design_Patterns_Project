import 'package:design_patterns_project/Classes/factory/boardingFactory/AbstractBoardingOption.dart';
import 'package:design_patterns_project/Classes/Strategy/roomStrategy/RoomStrategy.dart';
import 'package:design_patterns_project/Classes/room.dart';
import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/CostCalculationStrategy.dart';

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
}

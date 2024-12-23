import 'package:design_patterns_project/Abstract Boarding Option/AbstractBoardingOption.dart';
import 'package:design_patterns_project/abstract_room.dart';

class Booking {
  //int id;
  //int DurationOfStay;
  DateTime checkInDate;
  DateTime checkOutDate;
  AbstractRoom room;
  AbstractBoardingOption boardingOption;

  Booking( this.checkInDate, this.checkOutDate, this.room, this.boardingOption);

  Map<String, dynamic> toMap() {
  return {
    'checkInDate': checkInDate.toIso8601String(),
    'checkOutDate': checkOutDate.toIso8601String(),
    'room': room.toMap(),
    'boarding': boardingOption.toMap(),
    
  };
}


  // void displayDetails() {
  //   print('$DurationOfStay $boardingOption $room $id');
  // }
}
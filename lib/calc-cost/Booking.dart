import 'package:design_patterns_project/Abstract%20Boarding%20Option/AbstractBoardingOption.dart';
import 'package:design_patterns_project/abstract_room.dart';

class Booking {
   int _id;
   int _DurationOfStay;
   AbstractRoom _room ;
   AbstractBoardingOption _boardingOption;


   Booking(this._id,this._DurationOfStay,this._room,this._boardingOption);

  
   int get id => _id;

  
  set id(int newId) {
    _id = newId;
  }

 
  int get DurationOfStay => _DurationOfStay;

  
  set DurationOfStay(int newDuration) {
    _DurationOfStay = newDuration;
  }

 
  AbstractRoom get room => _room;

 
  set room(AbstractRoom newRoom) {
    _room = newRoom;
  }

  
  AbstractBoardingOption get boardingOption => _boardingOption;

  
  set boardingOption(AbstractBoardingOption newBoardingOption) {
    _boardingOption = newBoardingOption;
  }
 void displayDetails(){
      print('$_DurationOfStay $_boardingOption $_room $_id');
 }
  

}
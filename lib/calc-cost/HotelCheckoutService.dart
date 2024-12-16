import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';
import 'package:flutter/material.dart';

class HotelCheckoutService {
AbstractRoom _Room ;
CostCalculationStrategy _boardingStrategy;

HotelCheckoutService(this._Room,this._boardingStrategy);
 


   AbstractRoom get Room => _Room;

   set Room(AbstractRoom newRoom){
    _Room=newRoom;
   }

   CostCalculationStrategy get boardingStrategy=>_boardingStrategy;

   set boardingStrategy(CostCalculationStrategy newStrategy){
    _boardingStrategy=newStrategy;

   }

   calculateTotalCost(int nights){
      return _boardingStrategy.calculateCost(nights);
   }


}

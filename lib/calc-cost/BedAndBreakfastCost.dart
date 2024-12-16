import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';

class BedAndBreakfastCost implements CostCalculationStrategy{
   double calculateCost(int nights){
    return nights * 250.0;
   }
}
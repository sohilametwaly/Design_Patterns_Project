import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';

class HalfBoardingCost implements CostCalculationStrategy{
  double calculateCost(int nights){
     return nights*150.0;
  }
    
  }

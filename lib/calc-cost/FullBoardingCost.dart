

import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';

class FullBoardingCost implements CostCalculationStrategy {
  double calculateCost(int nights) {
   
    return nights * 500.0;
  }
}
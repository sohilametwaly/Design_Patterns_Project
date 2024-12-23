import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';
import '../Abstract Boarding Option/HalfBoard.dart';


class HalfBoardingCost implements CostCalculationStrategy {
  double calculateCost(int nights) {
    
    return nights * 250.0;
  }
}
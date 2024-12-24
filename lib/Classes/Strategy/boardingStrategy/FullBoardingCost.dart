import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/CostCalculationStrategy.dart';

class FullBoardingCost implements CostCalculationStrategy {
  double calculateCost(int nights) {
    return nights * 500.0;
  }
}

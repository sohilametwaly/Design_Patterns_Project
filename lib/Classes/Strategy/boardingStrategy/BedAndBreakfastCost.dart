import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/CostCalculationStrategy.dart';

class BedAndBreakfastCost implements CostCalculationStrategy {
  double calculateCost(int nights) {
    return nights * 200.0;
  }
}
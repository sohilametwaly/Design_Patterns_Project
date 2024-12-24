import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/CostCalculationStrategy.dart';
import '../../factory/boardingFactory/HalfBoard.dart';

class HalfBoardingCost implements CostCalculationStrategy {
  double calculateCost(int nights) {
    return nights * 250.0;
  }
}

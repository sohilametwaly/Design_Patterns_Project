import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/BedAndBreakfastCost.dart';
import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/CostCalculationStrategy.dart';
import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/FullBoardingCost.dart';
import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/HalfBoardingCost.dart';

class CostCalculationFactory {
  static CostCalculationStrategy CreateBoardingOption(String StrategyOption) {
    switch (StrategyOption.toLowerCase()) {
      case 'full board':
        return FullBoardingCost();
      case 'half board':
        return HalfBoardingCost();
      case 'bed and breakfast':
        return BedAndBreakfastCost();
      default:
        throw Exception("Invalid boarding option: $StrategyOption");
    }
  }
}

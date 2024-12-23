
import 'package:design_patterns_project/calc-cost/BedAndBreakfastCost.dart';
import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';
import 'package:design_patterns_project/calc-cost/FullBoardingCost.dart';
import 'package:design_patterns_project/calc-cost/HalfBoardingCost.dart';


class CostCalculationFactory  {
   static CostCalculationStrategy CreateBoardingOption(String StrategyOption){
       switch(StrategyOption.toLowerCase()){
        case'full board': return FullBoardingCost();
        case'half board': return HalfBoardingCost();
        case'bed and breakfast':return BedAndBreakfastCost();
        default:throw Exception("Invalid boarding option: $StrategyOption");
       }
   }
}
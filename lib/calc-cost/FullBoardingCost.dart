
import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';
import '../Database.dart';
class FullBoardingCost implements CostCalculationStrategy{
   double calculateCost(int nights){
     Database database = Database.getInstance();
     double price = database.readData('boardingOptions/FullBoard/price');
    return nights * price;
   }
}
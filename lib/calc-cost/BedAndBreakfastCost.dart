import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';
import '../Database.dart';

class BedAndBreakfastCost implements CostCalculationStrategy {
  double calculateCost(int nights) {
    Database database = Database.getInstance();
    double price = database.readData('boardingOptions/BedAndBreakFast/price');
    return nights * price;
  }
}
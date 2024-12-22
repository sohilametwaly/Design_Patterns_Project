import 'package:design_patterns_project/calc-cost/CostCalculationStrategy.dart';

import '../Abstract Boarding Option/HalfBoard.dart';
import '../Database.dart';

class HalfBoardingCost implements CostCalculationStrategy{
  double calculateCost(int nights){
    Database database = Database.getInstance();
    double price = database.readData('boardingOptions/HalfBoard/price');
    return nights * price;
  }
    
  }

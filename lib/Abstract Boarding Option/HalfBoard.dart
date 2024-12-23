import 'package:design_patterns_project/Abstract%20Boarding%20Option/AbstractBoardingOption.dart';

class HalfBoard extends AbstractBoardingOption{

    HalfBoard():super("Half board",300.0);

  String getMealPlan(){
     return "Half board includes breakfast and dinner.";
  }

}
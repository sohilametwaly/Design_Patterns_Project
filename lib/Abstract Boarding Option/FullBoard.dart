import 'package:design_patterns_project/Abstract%20Boarding%20Option/AbstractBoardingOption.dart';

class FullBoard extends AbstractBoardingOption{

    FullBoard():super("full board",500.0);

  String getMealPlan(){
     return "Full board includes breakfast, lunch, and dinner.";
  }

}
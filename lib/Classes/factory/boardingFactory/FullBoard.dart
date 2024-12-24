import 'package:design_patterns_project/Classes/factory/boardingFactory/AbstractBoardingOption.dart';

class FullBoard extends AbstractBoardingOption {
  FullBoard() : super("full board");

  String getMealPlan() {
    return "Full board includes breakfast, lunch, and dinner.";
  }
}

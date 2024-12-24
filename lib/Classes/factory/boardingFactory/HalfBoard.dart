import 'package:design_patterns_project/Classes/factory/boardingFactory/AbstractBoardingOption.dart';

class HalfBoard extends AbstractBoardingOption {
  HalfBoard() : super("Half board");

  String getMealPlan() {
    return "Half board includes breakfast and dinner.";
  }
}

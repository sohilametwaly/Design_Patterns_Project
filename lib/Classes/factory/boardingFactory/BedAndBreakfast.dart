import 'package:design_patterns_project/Classes/factory/boardingFactory/AbstractBoardingOption.dart';

class BedAndBreakfast extends AbstractBoardingOption {
  BedAndBreakfast() : super("bed and breakfast ");

  String getMealPlan() {
    return "bed and breakfast includes breakfast only ";
  }
}

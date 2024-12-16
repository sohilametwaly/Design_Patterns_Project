import 'package:design_patterns_project/Abstract%20Boarding%20Option/AbstractBoardingOption.dart';

class BedAndBreakfast extends AbstractBoardingOption{

    BedAndBreakfast():super("bed and breakfast ",80.0);

  String getMealPlan(){
     return "bed and breakfast includes breakfast only ";
  }

}
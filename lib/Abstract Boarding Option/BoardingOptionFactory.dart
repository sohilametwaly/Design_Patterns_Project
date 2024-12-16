import 'package:design_patterns_project/Abstract%20Boarding%20Option/AbstractBoardingOption.dart';
import 'package:design_patterns_project/Abstract%20Boarding%20Option/BedAndBreakfast.dart';
import 'package:design_patterns_project/Abstract%20Boarding%20Option/FullBoard.dart';
import 'package:design_patterns_project/Abstract%20Boarding%20Option/HalfBoard.dart';

class Boardingoptionfactory {
   static AbstractBoardingOption CreateBoardingOption(String boardingOption){
       switch(boardingOption.toLowerCase()){
        case'full board': return FullBoard();
        case'half board': return HalfBoard();
        case'bed and breakfast':return BedAndBreakfast();
        default:throw Exception("Invalid boarding option: $boardingOption");
       }
   } 
}
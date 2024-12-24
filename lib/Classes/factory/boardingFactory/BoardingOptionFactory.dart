import 'package:design_patterns_project/Classes/factory/boardingFactory/AbstractBoardingOption.dart';
import 'package:design_patterns_project/Classes/factory/boardingFactory/BedAndBreakfast.dart';
import 'package:design_patterns_project/Classes/factory/boardingFactory/FullBoard.dart';
import 'package:design_patterns_project/Classes/factory/boardingFactory/HalfBoard.dart';

class Boardingoptionfactory {
  static AbstractBoardingOption CreateBoardingOption(String boardingOption) {
    switch (boardingOption.toLowerCase()) {
      case 'full board':
        return FullBoard();
      case 'half board':
        return HalfBoard();
      case 'bed and breakfast':
        return BedAndBreakfast();
      default:
        throw Exception("Invalid boarding option: $boardingOption");
    }
  }
}

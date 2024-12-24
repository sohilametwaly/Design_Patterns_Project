import 'package:design_patterns_project/Classes/Strategy/roomStrategy/DoupleRoom.dart';
import 'package:design_patterns_project/Classes/Strategy/roomStrategy/RoomStrategy.dart';
import 'package:design_patterns_project/Classes/Strategy/roomStrategy/SingleRoom.dart';
import 'package:design_patterns_project/Classes/Strategy/roomStrategy/TripleRoom.dart';

class RoomStrategyFactory {
  static Roomstrategy CreateBoardingOption(String StrategyOption) {
    switch (StrategyOption.toLowerCase()) {
      case 'single':
        return SingleRoom();
      case 'double':
        return DoupleRoom();
      case 'triple':
        return TripleRoom();
      default:
        throw Exception("Invalid boarding option: $StrategyOption");
    }
  }
}

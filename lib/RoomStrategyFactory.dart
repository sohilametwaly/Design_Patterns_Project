import 'package:design_patterns_project/DoupleRoom.dart';
import 'package:design_patterns_project/RoomStrategy.dart';
import 'package:design_patterns_project/SingleRoom.dart';
import 'package:design_patterns_project/TripleRoom.dart';

class RoomStrategyFactory {
   static Roomstrategy CreateBoardingOption(String StrategyOption){
       switch(StrategyOption.toLowerCase()){
        case'single': return SingleRoom();
        case'double': return DoupleRoom();
        case'triple':return TripleRoom();
        default:throw Exception("Invalid boarding option: $StrategyOption");
       }
   }
}
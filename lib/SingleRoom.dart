import 'package:design_patterns_project/RoomStrategy.dart';


class SingleRoom implements Roomstrategy{
    double calculateCost(int nights){
       return nights * 150.0;
    }
}
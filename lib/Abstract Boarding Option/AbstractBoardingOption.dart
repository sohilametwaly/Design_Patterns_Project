abstract class AbstractBoardingOption {
  String _name;
  double _costPerNight;

    Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'costPerNight': _costPerNight,
    };
  }

  


  AbstractBoardingOption(this._name,this._costPerNight);

      String getMealPlan();

    

  
} 
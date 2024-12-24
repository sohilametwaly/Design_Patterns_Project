abstract class AbstractBoardingOption {
  String _name;

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
    };
  }

  AbstractBoardingOption(this._name);

  String getMealPlan();
}


import 'package:design_patterns_project/calc-cost/Booking.dart';

class Resident {
  String? _id;
  String? _name;
  String? _email;
  String? _phone;

  int? getId() => _id;

  void setId(int id) {
    this._id = id;
  }


  String? getName() => _name;

  void setName(String name) {
    _name = name;
  }


  String? getEmail() => _email;

  void setEmail(String email) {
    _email = email;
  }


  String? getPhone() => _phone;

  void setPhone(String phone) {
    _phone = phone;
  }


  void pay() {
    print("Resident is paying");
  }
}
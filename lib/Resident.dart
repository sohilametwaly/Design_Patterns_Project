import 'package:design_patterns_project/calc-cost/Booking.dart';

class Resident {
  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  Booking? _booking;


  Resident({String? id, String? name, String? email, String? phone, Booking? booking}) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _booking = booking;
  }


  Booking? get booking => _booking;

  set booking(Booking? value) {
    _booking = value;
  }


  String? getId() => _id;

  void setId(String id) {
    _id = id;
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

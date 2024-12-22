import 'package:design_patterns_project/calc-cost/Booking.dart';


class Resident {
  int id;
  String name;
  String email;
  String phone;
  Booking booking;


  Resident(this.id, this.name, this.email, this.phone, this.booking);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'booking': booking
    };
  } 
  // Booking? get booking => _booking;

  // set booking(Booking? value) {
  //   _booking = value;
  // }


  // int? getId() => _id;

  // void setId(int id) {
  //   _id = id;
  // }


  // String? getName() => _name;

  // void setName(String name) {
  //   _name = name;
  // }


  // String? getEmail() => _email;

  // void setEmail(String email) {
  //   _email = email;
  // }


  // String? getPhone() => _phone;

  // void setPhone(String phone) {
  //   _phone = phone;
  // }


  void pay() {
    print("Resident is paying");
  }


}

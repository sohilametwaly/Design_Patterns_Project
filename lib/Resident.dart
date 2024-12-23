import 'package:design_patterns_project/calc-cost/Booking.dart';

class Resident {
  String id;
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
      'booking': booking.toMap()
    };
  }

  void pay() {
    print("Resident is paying");
  }
}

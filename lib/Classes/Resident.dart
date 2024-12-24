import 'package:design_patterns_project/Classes/Booking.dart';

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

  Resident.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        email = map['email'],
        phone = map['phone'],
        booking = map['booking'];

  void pay() {
    print("Resident is paying");
  }
}

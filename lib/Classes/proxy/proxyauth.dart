import 'package:design_patterns_project/Classes/User.dart';
import 'package:design_patterns_project/Classes/proxy/authentication.dart';
import 'package:design_patterns_project/Classes/proxy/realauth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../singleton/Database.dart';

class Proxyauth implements Authentication {
  final realauth real = realauth();
  Database database = Database.getInstance();
  bool isManager = false;

  Future<void> login(String email, String password) async {
    if (validateInputs(email, password)) {
      await real.login(email, password);
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> forgetpassword(String email) async {
    if (email.isNotEmpty) {
      await real.forgetpassword(email);
    } else {
      throw Exception('email cannot be empty');
    }
  }

  Future<void> signup(String username, String password, String email) async {
    if (validateInputs(email, password) && email.contains('@')) {
      await real.signup(username, password, email);
      Map<String, dynamic> data = {
        'username': username,
        'email': email,
        'isManager': isManager
      };
      firebase_auth.User? currentUser =
          firebase_auth.FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      database.writeData('users/$userId', data);
    } else {
      throw Exception('Invalid signup details');
    }
  }

  bool validateInputs(String email, String password) {
    return email.isNotEmpty && password.length >= 6;
  }
}

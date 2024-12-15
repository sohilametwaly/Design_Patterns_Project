import 'package:design_patterns_project/authentication.dart';
import 'package:design_patterns_project/realauth.dart';

class Proxyauth implements Authentication {
  final realauth real = realauth();

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
    } else {
      throw Exception('Invalid signup details');
    }
  }

  bool validateInputs(String email, String password) {
    return email.isNotEmpty && password.length >= 6;
  }
}

import 'package:design_patterns_project/Classes/proxy/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class realauth implements Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> forgetpassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signup(String username, String password, String email) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}

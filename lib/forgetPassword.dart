import 'package:design_patterns_project/login/loginpage.dart';
import 'package:design_patterns_project/proxyauth.dart';
import 'package:design_patterns_project/realauth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Forgetpassword extends StatefulWidget {
  @override
  ForgetpasswordState createState() => ForgetpasswordState();
}

class ForgetpasswordState extends State<Forgetpassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Proxyauth proxy = Proxyauth();

  Future<void> Forgetpassword(String email) async {
    try {
      await proxy.forgetpassword(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('password reset email sent to your email')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error!')),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Forgetpassword(emailController.text);
                      //Navigate to the Login page
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                    child: Text("Reset password"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

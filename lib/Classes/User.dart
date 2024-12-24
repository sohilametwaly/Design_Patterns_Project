import 'package:design_patterns_project/Classes/singleton/Database.dart';

class User {
  late String _username;
  late String _password;
  late String _role;
  Database databaseInstance = Database.getInstance();
  // late AuthProxy loginProxy;

  User(this._username, this._password, this._role);

  getUsername() {
    return _username;
  }

  setUsername(String value) {
    _username = value;
  }

  getPassword() {
    return _password;
  }

  setPassword(String value) {
    _password = value;
  }

  getRole() {
    return _role;
  }

  setRole(String value) {
    _role = value;
  }
}

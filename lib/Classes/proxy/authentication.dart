abstract class Authentication {
  Future<void> login(String email, String password);
  Future<void> forgetpassword(String email);
  Future<void> signup(String username, String password, String email);
}

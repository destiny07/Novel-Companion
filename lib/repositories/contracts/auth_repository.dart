abstract class AuthRepository {
  bool get isAuthenticated;
  String? get userId;

  Future<void> signInWithGoogle();

  Future<void> signInWithApple();

  Future<void> signInWithEmail(String email, String password);

  Future<void> signUpWithEmail(String email, String password);

  Future<void> resetPassword(String email);

  Future sendEmailVerification();
}

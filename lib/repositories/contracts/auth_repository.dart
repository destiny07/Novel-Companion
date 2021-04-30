abstract class AuthRepository {
  Future<bool> isAuthenticated();

  Future<void> signInWithGoogle();

  Future<void> signInWithApple();

  Future<void> signInWithEmail(String email, String password);

  Future<void> signUpWithEmail(String email, String password);

  Future<String> getUserId();

  Future<void> resetPassword(String email);

  Future sendEmailVerification();
}

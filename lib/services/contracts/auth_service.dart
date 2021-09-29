import 'package:project_lyca/models/models.dart' as models;
import 'package:project_lyca/models/models.dart';

abstract class AuthService {
  bool get isAuthenticated;
  String? get userId;
  Stream<User?> get status;
  models.User? get user;

  Future<void> signInWithGoogle();

  Future<void> signInWithApple();

  Future<void> signInWithEmail(String email, String password);

  Future<void> signUpWithEmail(String email, String password);

  Future<void> changePassword(String password);

  Future<void> resetPassword(String email);

  Future sendEmailVerification();

  Future<void> signOut();

  Future<void> refreshUser();
}

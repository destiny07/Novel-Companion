import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_lyca/models/models.dart' as models;
import 'package:project_lyca/services/contracts/auth_service.dart';
import 'package:project_lyca/services/exceptions/auth_exceptions.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  bool get isAuthenticated {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  String? get userId {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Stream<bool> get status {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser != null;
    });
  }

  @override
  models.User? get user {
    var firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }

    return models.User(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        name: firebaseUser.displayName,
        photo: firebaseUser.photoURL,
        isEmailVerified: firebaseUser.emailVerified);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<void> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      await _firebaseAuth.signInWithCredential(oauthCredential);
    } catch (err) {
      throw SignInWithAppleFailure();
    }
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw SignInWithGoogleFailure();
    }
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await result.user!.sendEmailVerification();
    } on Exception {
      throw SignUpFailure();
    }
  }

  @override
  Future<void> changePassword(String password) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(password);
    } on Exception {
      throw ChangePasswordFailure();
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception {
      throw ResetPasswordFailure();
    }
  }

  @override
  Future sendEmailVerification() async {
    try {
      var user = _firebaseAuth.currentUser;
      await user!.sendEmailVerification();
    } on Exception {
      throw SendEmailVerificationFailure();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> refreshUser() async {
    await _firebaseAuth.currentUser?.reload();
  }
}

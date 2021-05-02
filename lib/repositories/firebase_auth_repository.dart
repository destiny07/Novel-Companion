import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_lyca/repositories/contracts/auth_repository.dart';
import 'package:project_lyca/repositories/exceptions/exceptions.dart';

class FirebaseUserRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseUserRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignin,
  })   : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignin;

  bool get isAuthenticated {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  String? get userId {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<void> signInWithApple() {
    // TODO: Implement sign in with Apple
    throw UnimplementedError();
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
}

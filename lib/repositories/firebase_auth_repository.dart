import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_lyca/repositories/contracts/auth_repository.dart';
import 'package:project_lyca/repositories/exceptions/exceptions.dart';
import 'package:project_lyca/models/models.dart' as models;

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository() : _firebaseAuth = FirebaseAuth.instance;

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
    );
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
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
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

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}

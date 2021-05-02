class SignUpFailure implements Exception {}

class SignInWithEmailAndPasswordFailure implements Exception {
  final String? message;

  const SignInWithEmailAndPasswordFailure({this.message});
}

class SignInWithGoogleFailure implements Exception {}

class SignInWithAppleFailure implements Exception {}

class ResetPasswordFailure implements Exception {}

class SendEmailVerificationFailure implements Exception {}

class LogOutFailure implements Exception {}

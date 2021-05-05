part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.isVerificationSent = false,
  });

  final FormzStatus status;
  final Email email;
  final bool isVerificationSent;

  ForgotPasswordState copyWith({
    FormzStatus? status,
    Email? email,
    bool? isVerificationSent,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      isVerificationSent: isVerificationSent ?? this.isVerificationSent
    );
  }

  @override
  List<Object> get props => [status, email, isVerificationSent];
}

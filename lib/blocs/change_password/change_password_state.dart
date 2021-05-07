part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = FormzStatus.pure,
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure()
  });

  final FormzStatus status;
  final Password password;
  final Password confirmPassword;

  ChangePasswordState copyWith({
    FormzStatus? status,
    Password? password,
    Password? confirmPassword,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object> get props => [status, password, confirmPassword];
}

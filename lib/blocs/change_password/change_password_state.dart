part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = FormzStatus.pure,
    this.statusMessage = '',
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
  });

  final FormzStatus status;
  final String statusMessage;
  final Password password;
  final Password confirmPassword;

  ChangePasswordState copyWith({
    FormzStatus? status,
    String? statusMessage,
    Password? password,
    Password? confirmPassword,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object> get props => [status, statusMessage, password, confirmPassword];
}

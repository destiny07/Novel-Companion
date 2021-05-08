part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.statusMessage = '',
  });

  final FormzStatus status;
  final String statusMessage;
  final Email email;
  final Password password;

  LoginState copyWith({
    FormzStatus? status,
    String? statusMessage,
    Email? email,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, statusMessage, email, password];
}

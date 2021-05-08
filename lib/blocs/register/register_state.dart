part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.statusMessage = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final String statusMessage;
  final Email email;
  final Password password;

  RegisterState copyWith({
    FormzStatus? status,
    String? statusMessage,
    Email? email,
    Password? password,
  }) {
    return RegisterState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, statusMessage, email, password];
}

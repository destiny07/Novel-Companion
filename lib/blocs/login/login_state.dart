part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.statusMessage = '',
  });

  final String statusMessage;

  LoginState copyWith({
    String? statusMessage,
  }) {
    return LoginState(
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [statusMessage];
}

part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.statusMessage = '',
    this.isLoginSuccess = false,
  });

  final String statusMessage;
  final bool isLoginSuccess;

  LoginState copyWith({
    String? statusMessage,
    bool? isLoginSuccess,
  }) {
    return LoginState(
      statusMessage: statusMessage ?? this.statusMessage,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
    );
  }

  @override
  List<Object> get props => [statusMessage, isLoginSuccess];
}

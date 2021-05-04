part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.isAuthenticated);

  final bool isAuthenticated;

  @override
  List<Object> get props => [isAuthenticated];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationResendEmailVerification extends AuthenticationEvent {}

class AuthenticationRefreshUser extends AuthenticationEvent {}

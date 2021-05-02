part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({this.isAuthenticated = false, this.user});

  const AuthenticationState.authenticated(User user)
      : this._(isAuthenticated: true, user: user);

  const AuthenticationState.unauthenticated() : this._();

  final bool isAuthenticated;
  final User? user;

  @override
  List<Object?> get props => [isAuthenticated, user];
}

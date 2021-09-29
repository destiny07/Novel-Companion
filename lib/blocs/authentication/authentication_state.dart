part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({this.isAuthenticated = false, this.user});

  const AuthenticationState.authenticated(User user)
      : this._(isAuthenticated: true, user: user);

  const AuthenticationState.unauthenticated() : this._();

  final bool isAuthenticated;
  final User? user;

  AuthenticationState copyWith({
    bool? isAuthenticated,
    User? user,
  }) {
    return AuthenticationState._(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, user];
}

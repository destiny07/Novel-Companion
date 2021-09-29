import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/services/services.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.authenticationService})
      : super(const AuthenticationState.unauthenticated()) {
    _isAuthenticatedSubscription = authenticationService.status.listen(
      (status) => emit(state.copyWith(isAuthenticated: status != null, user: status)),
    );
  }

  late StreamSubscription<User?> _isAuthenticatedSubscription;
  final AuthService authenticationService;

  @override
  Future<void> close() {
    _isAuthenticatedSubscription.cancel();
    return super.close();
  }

  void logout() async {
    await authenticationService.signOut();
  }

  void resendVerification() async {
    await authenticationService.sendEmailVerification();
  }

  void refreshUser() async {
    await authenticationService.refreshUser();
    emit(AuthenticationState.authenticated(authenticationService.user!));
  }
}
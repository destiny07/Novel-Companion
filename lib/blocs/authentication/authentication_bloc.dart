import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authenticationRepository;
  late StreamSubscription<bool> _isAuthenticatedSubscription;

  AuthenticationBloc({required AuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unauthenticated()) {
    _isAuthenticatedSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      await _authenticationRepository.signOut();
    } else if (event is AuthenticationResendEmailVerification) {
      await _authenticationRepository.sendEmailVerification();
    } else if (event is AuthenticationRefreshUser) {
      yield* _mapAuthenticationRefreshUserToState();
    }
  }

  @override
  Future<void> close() {
    _isAuthenticatedSubscription.cancel();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    if (!event.isAuthenticated) {
      return const AuthenticationState.unauthenticated();
    }
    final user = _authenticationRepository.user;
    return user != null
        ? AuthenticationState.authenticated(user)
        : const AuthenticationState.unauthenticated();
  }

  Stream<AuthenticationState> _mapAuthenticationRefreshUserToState() async* {
    await _authenticationRepository.refreshUser();
    yield AuthenticationState.authenticated(_authenticationRepository.user!);
  }
}

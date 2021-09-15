import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGoogle) {
      yield* _mapLoginWithGoogleToState(event, state);
    } else if (event is LoginWithApple) {
      yield* _mapLoginWithAppleToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState(
    LoginWithGoogle event,
    LoginState state,
  ) async* {
    await _authenticationRepository.signInWithGoogle();
  }

  Stream<LoginState> _mapLoginWithAppleToState(
    LoginWithApple event,
  ) async* {
    await _authenticationRepository.signInWithApple();
  }
}

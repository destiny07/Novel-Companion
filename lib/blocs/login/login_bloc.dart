import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/services/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authenticationService,
  })  : super(const LoginState());

  final AuthService authenticationService;

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
    await authenticationService.signInWithGoogle();
  }

  Stream<LoginState> _mapLoginWithAppleToState(
    LoginWithApple event,
  ) async* {
    await authenticationService.signInWithApple();
  }
}

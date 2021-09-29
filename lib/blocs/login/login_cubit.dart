import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/services/services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authenticationService,
  })  : super(const LoginState());

  final AuthService authenticationService;

  void loginWithGoogle() async {
    try {
      await authenticationService.signInWithGoogle();
      emit(state.copyWith(isLoginSuccess: true));
    } catch (err) {
      emit(state.copyWith(
        isLoginSuccess: false,
        statusMessage: 'Error signing in with Google',
      ));
    }
  }

  void mapLoginWithApple() async {
    try {
      await authenticationService.signInWithApple();
      emit(state.copyWith(isLoginSuccess: true));
    } catch (err) {
      emit(state.copyWith(
        isLoginSuccess: false,
        statusMessage: 'Error signing in with Apple',
      ));
    }
  }
}

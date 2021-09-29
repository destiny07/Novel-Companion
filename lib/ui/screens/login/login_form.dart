import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:project_lyca/blocs/blocs.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _googleLoginButton(context),
          _appleLoginButton(context),
        ],
      ),
    );
  }
}

Widget _googleLoginButton(BuildContext context) {
  return SignInButton(
    Buttons.Google,
    onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
  );
}

Widget _appleLoginButton(BuildContext context) {
  return SignInButton(
    Buttons.Apple,
    onPressed: () => context.read<LoginCubit>().mapLoginWithApple(),
  );
}

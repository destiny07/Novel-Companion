import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:project_lyca/blocs/blocs.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _googleLoginButton(context),
        _appleLoginButton(context),
      ],
    );
  }
}

Widget _googleLoginButton(BuildContext context) {
  return SignInButton(
    Buttons.Google,
    onPressed: () {
      var authBloc = BlocProvider.of<LoginBloc>(context, listen: false);
      authBloc.add(LoginWithGoogle());
    },
  );
}

Widget _appleLoginButton(BuildContext context) {
  return SignInButton(
    Buttons.Apple,
    onPressed: () {
      var authBloc = BlocProvider.of<LoginBloc>(context, listen: false);
      authBloc.add(LoginWithGoogle());
    },
  );
}
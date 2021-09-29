import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:project_lyca/blocs/blocs.dart';

class AppleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Apple,
      onPressed: () => context.read<LoginCubit>().mapLoginWithApple(),
    );
  }
}
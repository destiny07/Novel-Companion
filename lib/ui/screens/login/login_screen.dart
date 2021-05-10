import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:project_lyca/blocs/login/login_bloc.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthRepository>(context),
              );
            },
            child: BlocListener<LoginBloc, LoginState>(
              listenWhen: (previousState, state) =>
                  previousState.status != state.status &&
                  state.status == FormzStatus.submissionFailure,
              listener: (context, state) {
                Fluttertoast.showToast(
                  msg: state.statusMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}

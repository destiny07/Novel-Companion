import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:project_lyca/blocs/change_password/change_password_bloc.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

class ChangePasswordScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ChangePasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (context) {
              return ChangePasswordBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthRepository>(context),
              );
            },
            child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
              listenWhen: (previousState, state) =>
                  previousState.status != state.status &&
                  (state.status == FormzStatus.submissionSuccess ||
                      state.status == FormzStatus.submissionFailure),
              listener: (context, state) {
                var toastColor = Colors.red;

                if (state.status == FormzStatus.submissionSuccess) {
                  toastColor = Colors.green;
                }

                Fluttertoast.showToast(
                  msg: state.statusMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: toastColor,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );

                if (state.status == FormzStatus.submissionSuccess) {
                  Navigator.of(context).pop();
                }
              },
              child: Column(
                children: [
                  _PasswordInput(),
                  _ConfirmPasswordInput(),
                  _ChangePasswordSubmittedButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('changePasswordForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<ChangePasswordBloc>()
              .add(ChangePasswordPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('changePasswordForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<ChangePasswordBloc>()
              .add(ChangePasswordConfirmPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            errorText: state.password.invalid ? 'passwords not matching' : null,
          ),
        );
      },
    );
  }
}

class _ChangePasswordSubmittedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          child: const Text('Login'),
          onPressed: state.status == FormzStatus.valid ||
                  state.status == FormzStatus.submissionInProgress
              ? () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  context
                      .read<ChangePasswordBloc>()
                      .add(const ChangePasswordSubmitted());
                }
              : null,
        );
      },
    );
  }
}

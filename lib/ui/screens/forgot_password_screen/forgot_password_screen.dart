import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

import 'forgot_password_form.dart';
import 'forgot_password_sent.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ForgotPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: BlocProvider(
            create: (context) {
              return ForgotPasswordBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthRepository>(context),
              );
            },
            child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              buildWhen: (previous, current) => previous.isVerificationSent != current.isVerificationSent,
              builder: (context, state) {
                if (state.isVerificationSent) {
                  return ForgotPasswordSent();
                }

                return ForgotPasswordForm();
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EmailInput(),
        ElevatedButton(
          child: Text('Change password'),
          onPressed: () {
            final authBloc = BlocProvider.of<ForgotPasswordBloc>(context);
            authBloc.add(ForgotPasswordSubmittedEvent());
          },
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('forgotPasswordForm_emailInput_textField'),
          onChanged: (username) => context
              .read<ForgotPasswordBloc>()
              .add(ForgotPasswordEmailChanged(username)),
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.email.invalid ? 'invalid username' : null,
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';

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
          child: Column(
            children: [
              ElevatedButton(
                child: Text('Change password'),
                onPressed: () {
                  final authBloc = BlocProvider.of<ForgotPasswordBloc>(context);
                  authBloc.add(ForgotPasswordSubmittedEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

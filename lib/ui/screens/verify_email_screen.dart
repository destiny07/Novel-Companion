import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

class VerifyEmailScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => VerifyEmailScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please verify your email'),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                buildWhen: (previous, current) => previous.user != current.user,
                builder: (context, state) {
                  return Text(state.user!.email!);
                },
              ),
              ElevatedButton(
                child: Text('Refresh'),
                onPressed: () {
                  final authBloc = BlocProvider.of<AuthenticationBloc>(context);
                  authBloc.add(AuthenticationRefreshUser());
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not you?'),
                  TextButton(
                    child: Text('Logout'),
                    onPressed: () {
                      final authBloc =
                          BlocProvider.of<AuthenticationBloc>(context);
                      authBloc.add(AuthenticationLogoutRequested());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

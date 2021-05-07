import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/authentication/authentication_bloc.dart';
import 'package:project_lyca/ui/screens/change_password_screen.dart';

class SettingsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Change password'),
              onTap: () {
                Navigator.of(context).push(ChangePasswordScreen.route());
              },
            ),
            Divider(thickness: 1.0),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
            Divider(thickness: 1.0),
          ],
        ),
      ),
    );
  }
}

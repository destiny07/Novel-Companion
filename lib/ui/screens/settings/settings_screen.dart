import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/authentication/authentication_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/ui/screens/change_password_screen.dart';
import 'package:project_lyca/ui/screens/settings/font_size_dialog.dart';

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
              title: Text('Theme'),
              subtitle: Text('Default'),
            ),
            Divider(),
            ListTile(
              title: Text('Font'),
              subtitle: Text('Arial'),
            ),
            Divider(),
            ListTile(
              title: Text('FontSize'),
              subtitle: _fontSize(),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return FontSizeDialog();
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Change password'),
              onTap: () {
                Navigator.of(context).push(ChangePasswordScreen.route());
              },
            ),
            Divider(),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _fontSize() {
    return BlocBuilder<UserConfigBloc, UserConfigState>(
      buildWhen: (previous, current) =>
          previous.userConfig!.fontSize != current.userConfig!.fontSize,
      builder: (context, state) => Text(state.userConfig!.fontSize.toString()),
    );
  }
}

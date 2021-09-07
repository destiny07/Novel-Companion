import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/authentication/authentication_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/ui/screens/settings/font_dialog.dart';
import 'package:project_lyca/ui/screens/settings/font_size_dialog.dart';
import 'package:project_lyca/constants.dart' as constants;
import 'package:project_lyca/ui/screens/settings/theme_dialog.dart';

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
              subtitle: _theme(),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => ThemeDialog(),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Font'),
              subtitle: _fontStyle(),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => FontDialog(),
                );
              },
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
              title: Text('Logout'),
              onTap: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());

                // Required so that login screen will be displayed
                // Not included when popping other routes?
                Navigator.of(context).pop();
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _fontStyle() {
    return BlocBuilder<UserConfigBloc, UserConfigState>(
      buildWhen: (previous, current) => previous.fontStyle != current.fontStyle,
      builder: (context, state) {
        final fontName = constants.fontNameMap[state.fontStyle]!;
        return Text(fontName);
      },
    );
  }

  Widget _fontSize() {
    return BlocBuilder<UserConfigBloc, UserConfigState>(
      buildWhen: (previous, current) => previous.fontSize != current.fontSize,
      builder: (context, state) => Text(state.fontSize.toString()),
    );
  }

  Widget _theme() {
    return BlocBuilder<UserConfigBloc, UserConfigState>(
      buildWhen: (previous, current) => previous.theme != current.theme,
      builder: (context, state) => Text(constants.themeNameMap[state.theme]!),
    );
  }
}

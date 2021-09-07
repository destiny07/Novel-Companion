import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/ui/screens/settings/settings_screen.dart';

class ActionBar extends StatelessWidget {
  final bool enable;

  ActionBar({required this.enable});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          splashColor: Theme.of(context).backgroundColor,
          icon: Icon(Icons.flash_on),
          color: Colors.white,
          onPressed: enable
              ? () {
                  BlocProvider.of<HomeBloc>(context).add(HomeToggleTorch());
                }
              : null,
        ),
        IconButton(
          splashColor: Theme.of(context).backgroundColor,
          icon: Icon(Icons.search_rounded),
          color: Colors.white,
          iconSize: 30.0,
          onPressed: enable
              ? () {
                  BlocProvider.of<HomeBloc>(context).add(HomeToggleSearchBar());
                }
              : null,
        ),
        IconButton(
          splashColor: Theme.of(context).backgroundColor,
          icon: Icon(Icons.settings),
          color: Colors.white,
          onPressed: enable
              ? () {
                  Navigator.of(context).push(SettingsScreen.route());
                }
              : null,
        ),
      ],
    );
  }
}

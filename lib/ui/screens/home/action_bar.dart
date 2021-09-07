import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashlight/flutter_flashlight.dart';
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
        _torchButton(),
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

  Widget _torchButton() {
    return FutureBuilder<bool?>(
      future: Flashlight.hasFlashlight,
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return IconButton(
            splashColor: Theme.of(context).backgroundColor,
            icon: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.isTorchOn) {
                  return Icon(Icons.flashlight_on_rounded);
                }

                return Icon(Icons.flashlight_off_rounded);
              },
            ),
            color: Colors.white,
            onPressed: enable
                ? () {
                    BlocProvider.of<HomeBloc>(context).add(HomeToggleTorch());
                  }
                : null,
          );
        }

        return IconButton(
          icon: Icon(Icons.flashlight_off_rounded),
          onPressed: null,
        );
      },
    );
  }
}

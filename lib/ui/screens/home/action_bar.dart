import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';

class ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.flash_on),
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.search_rounded),
          color: Colors.white,
          iconSize: 40.0,
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(HomeToggleSearchBar());
          },
        ),
        IconButton(
          icon: Icon(Icons.history_rounded),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
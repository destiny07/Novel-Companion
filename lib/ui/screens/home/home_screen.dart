import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/services/services.dart';
import 'package:project_lyca/ui/screens/home/action_bar.dart';
import 'package:project_lyca/ui/screens/home/camera_view.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  static Route route(List<CameraDescription> cameras) {
    return MaterialPageRoute<void>(
        builder: (_) => HomeScreen(
              cameras: cameras,
            ));
  }

  const HomeScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            return HomeBloc(
              dictionaryService: FirebaseDictionaryService(),
            );
          },
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                children: [
                  CameraView(cameras: widget.cameras),
                  Expanded(child: ActionBar()),
                ],
              ),
              CustomSearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isShowSearchBar != current.isShowSearchBar,
      builder: (context, state) {
        if (state.isShowSearchBar) {
          return Container(
            height: 30,
            margin: EdgeInsets.fromLTRB(8.0, 64, 8.0, 8.0),
            child: Padding(padding: EdgeInsets.all(8.0), child: TextField()),
            color: Colors.white,
            alignment: Alignment.topCenter,
          );
        }
        return Container();
      },
    );
  }
}
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/services/services.dart';
import 'package:project_lyca/ui/screens/home/action_bar.dart';
import 'package:project_lyca/ui/screens/home/camera_view.dart';
import 'package:project_lyca/ui/screens/home/search_bar.dart';
import 'package:project_lyca/ui/screens/home/word_info.dart';

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
              dictionaryService: FunctionsDictionaryService(),
            );
          },
          child: _HomeContent(widget.cameras),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final List<CameraDescription> cameras;
  final _cameraViewController = CameraViewController();

  _HomeContent(this.cameras);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CameraView(
              controller: _cameraViewController,
              cameras: cameras,
              onTapWord: (word) {
                print('The tapped word is $word');
                if (word.isEmpty) {
                  print('Word is empty');
                } else {
                  _cameraViewController.setEnableTap!(false);
                  BlocProvider.of<HomeBloc>(context).add(HomeTapText(word));
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _actionBar(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _searchBar(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _wordInfo(),
          ),
          Align(
            alignment: Alignment.center,
            child: _progressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _actionBar() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isSearchLoading != current.isSearchLoading,
      builder: (context, state) {
        return ActionBar(enable: !state.isSearchLoading);
      },
    );
  }

  Widget _searchBar() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isShowSearchBar != current.isShowSearchBar,
      builder: (context, state) {
        if (state.isShowSearchBar) {
          return Container(
            margin: EdgeInsets.fromLTRB(8.0, 24, 8.0, 8.0),
            child: SearchBar(),
          );
        }
        return Container();
      },
    );
  }

  Widget _wordInfo() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isShowWordInfo != current.isShowWordInfo ||
          previous.word != current.word,
      builder: (context, state) {
        if (state.isShowWordInfo) {
          return Container(
            margin: EdgeInsets.fromLTRB(8.0, 24, 8.0, 128.0),
            child: WordInfo(word: state.word!),
          );
        }
        return Container();
      },
    );
  }

  Widget _progressIndicator() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isSearchLoading != current.isSearchLoading,
      builder: (context, state) {
        if (state.isSearchLoading) {
          return CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}

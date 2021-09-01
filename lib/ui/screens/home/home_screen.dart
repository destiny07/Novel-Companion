import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';
import 'package:project_lyca/services/services.dart';
import 'package:project_lyca/ui/custom_font.dart';
import 'package:project_lyca/ui/custom_theme.dart';
import 'package:project_lyca/ui/screens/home/action_bar.dart';
import 'package:project_lyca/ui/screens/home/animated_word_info.dart';
import 'package:project_lyca/ui/screens/home/camera_view.dart';
import 'package:project_lyca/ui/screens/home/search_bar.dart';

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
                dataRepository: RepositoryProvider.of<DataRepository>(context));
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
      onHorizontalDragEnd: (details) {
        // Swipe Left
        if (details.primaryVelocity! < 0) {
          print('Swiped Left');
          BlocProvider.of<HomeBloc>(context).add(HomeToggleWordInfo(false));
          // Swipe Right
        } else if (details.primaryVelocity! > 0) {
          print('Swiped Right');
          BlocProvider.of<HomeBloc>(context).add(HomeToggleWordInfo(true));
        }
      },
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
            child: _wordInfo(context),
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
    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 24, 8.0, 128.0),
      child: SearchBar(
        onVisibilityChanged: (isVisible) {
          if (isVisible) {
            _cameraViewController.setEnableTap!(false);
          } else {
            _cameraViewController.setEnableTap!(true);
          }
        },
      ),
    );
  }

  Widget _wordInfo(BuildContext context) {
    return BlocBuilder<UserConfigBloc, UserConfigState>(
      builder: (context, state) => Container(
        margin: EdgeInsets.fromLTRB(8.0, 24, 8.0, 128.0),
        child: Theme(
          data: CustomTheme.getThemeByName(
            state.theme,
            textStyle: CustomFont.fontStyleMap[state.fontStyle]!,
          ),
          child: AnimatedWordInfo(
            onVisibilityChanged: (isVisible) {
              if (isVisible) {
                _cameraViewController.setEnableTap!(false);
              } else {
                _cameraViewController.setEnableTap!(true);
              }
            },
          ),
        ),
      ),
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

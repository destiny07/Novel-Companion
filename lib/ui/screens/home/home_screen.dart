import 'dart:io';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';
import 'package:project_lyca/services/services.dart';
import 'package:project_lyca/ui/custom_font.dart';
import 'package:project_lyca/ui/custom_theme.dart';
import 'package:project_lyca/ui/screens/home/action_bar.dart';
import 'package:project_lyca/ui/screens/home/animated_word_info.dart';
import 'package:project_lyca/ui/screens/home/camera_view.dart';
import 'package:project_lyca/ui/screens/home/search_bar.dart';
import 'package:project_lyca/ui/screens/home/search_progress.dart';

class HomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  static Route route(List<CameraDescription> cameras) {
    return MaterialPageRoute<void>(
        builder: (_) => HomeScreen(
              cameras: cameras,
            ));
  }

  const HomeScreen({Key? key, required this.cameras}) : super(key: key);
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
          child: BlocBuilder<UserConfigBloc, UserConfigState>(
            builder: (context, state) => Theme(
              data: CustomTheme.getThemeByName(
                state.theme,
                textStyle: CustomFont.fontStyleMap[state.fontStyle]!,
                fontSize: state.fontSize,
              ),
              child: _HomeContent(cameras),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  final List<CameraDescription> cameras;

  _HomeContent(this.cameras);

  @override
  State<StatefulWidget> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent>
    with WidgetsBindingObserver {
  final _cameraViewController = CameraViewController();
  bool _hasPermissions = false;
  bool _hasOpenedSettings = false;
  bool? _hasPermanentlyDeniedPermissions;

  void _reloadPermissions() {
    Permission.camera.status.then((camStatusValue) {
      if (Platform.isIOS) {
        setState(() {
          _hasPermissions = camStatusValue == PermissionStatus.granted;
          _hasPermanentlyDeniedPermissions = null;
        });
      } else {
        Permission.microphone.status.then((micStatusValue) {
          setState(() {
            _hasPermissions = camStatusValue == PermissionStatus.granted &&
                micStatusValue == PermissionStatus.granted;
            _hasPermanentlyDeniedPermissions = null;
          });
        });
      }
    });
  }

  void _requestPermission() {
    Permission.camera.request().then((camValue) {
      if (Platform.isIOS) {
        setState(() {
          print('request cam ios: ${camValue.isGranted}');
          _hasPermissions = camValue.isGranted;
          _hasPermanentlyDeniedPermissions = null;
          _hasOpenedSettings = false;
        });
      } else {
        Permission.microphone.request().then((micValue) {
          setState(() {
            _hasPermissions = camValue.isGranted && micValue.isGranted;
            _hasPermanentlyDeniedPermissions = null;
            _hasOpenedSettings = false;
          });
        });
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _hasOpenedSettings) {
      _reloadPermissions();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    _requestPermission();
    // _reloadPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _hasPermissions ? _content() : _noPermissionsContent();
  }

  Widget _content() {
    return GestureDetector(
      // onHorizontalDragEnd: (details) {
      //   // Swipe Left
      //   if (details.primaryVelocity! < 0) {
      //     print('Swiped Left');
      //     BlocProvider.of<HomeBloc>(context).add(HomeToggleWordInfo(false));
      //     // Swipe Right
      //   } else if (details.primaryVelocity! > 0) {
      //     print('Swiped Right');
      //     BlocProvider.of<HomeBloc>(context).add(HomeToggleWordInfo(true));
      //   }
      // },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: MultiBlocListener(
              listeners: [
                BlocListener<HomeBloc, HomeState>(
                  listenWhen: (previous, current) =>
                      previous.showTapAgain != current.showTapAgain,
                  listener: (context, state) async {
                    if (state.showTapAgain) {
                      await Fluttertoast.cancel();
                      await Fluttertoast.showToast(
                        msg: "Please tap again",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize,
                      );
                    }
                  },
                ),
                BlocListener<HomeBloc, HomeState>(
                  listenWhen: (previous, current) =>
                      !current.isWordFound &&
                      previous.inputWord != current.inputWord,
                  listener: (context, state) async {
                    if (!state.isWordFound) {
                      await Fluttertoast.cancel();
                      await Fluttertoast.showToast(
                        msg: state.description!,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize,
                      );
                    }
                  },
                )
              ],
              child: CameraView(
                controller: _cameraViewController,
                cameras: widget.cameras,
                onTapWord: (image, offset) async {
                  BlocProvider.of<HomeBloc>(context).add(
                    HomeTapText(inputImage: image, offset: offset),
                  );
                },
              ),
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

  Widget _noPermissionsContent() {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Camera permissions required.',
              style: TextStyle(color: Colors.blue),
            ),
            TextButton(
              child: Text('Give permission'),
              onPressed: () async {
                final camStatus = await Permission.camera.status;
                final micStatus = await Permission.microphone.status;

                if (Platform.isIOS &&
                    (camStatus == PermissionStatus.denied ||
                        micStatus == PermissionStatus.denied)) {
                  _hasOpenedSettings = true;
                  openAppSettings();
                  return;
                }

                if (_hasPermanentlyDeniedPermissions != null &&
                    _hasPermanentlyDeniedPermissions!) {
                  _hasOpenedSettings = true;
                  openAppSettings();
                  return;
                }

                _hasOpenedSettings = false;

                final reqStatus =
                    await [Permission.camera, Permission.microphone].request();

                if (reqStatus.values.contains(PermissionStatus.denied)) {
                  _hasPermanentlyDeniedPermissions = null;
                } else if (reqStatus.values
                    .contains(PermissionStatus.permanentlyDenied)) {
                  _hasPermanentlyDeniedPermissions = true;
                } else {
                  _reloadPermissions();
                }
              },
            )
          ],
        ),
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
    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 24, 8.0, 128.0),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (previous, current) {
          if (current.isShowWordInfo) {
            _cameraViewController.setEnableTap!(false);
          } else {
            _cameraViewController.setEnableTap!(true);
          }
        },
        listenWhen: (previous, current) =>
            previous.isShowWordInfo != current.isShowWordInfo,
        child: AnimatedWordInfo(),
      ),
    );
  }

  Widget _progressIndicator() {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isSearchLoading != current.isSearchLoading,
      builder: (context, state) {
        if (state.isSearchLoading) {
          return Container(
            margin: EdgeInsets.fromLTRB(8.0, 24, 8.0, 128.0),
            child: SearchProgress(
              onCancel: () {
                BlocProvider.of<HomeBloc>(context).add(HomeCancelSearchWord());
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

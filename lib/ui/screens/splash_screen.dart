import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/ui/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const SplashScreen({required this.cameras});

  static Route route(List<CameraDescription> cameras) {
    return MaterialPageRoute<void>(
      builder: (_) => SplashScreen(
        cameras: cameras,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserConfigBloc>(context).add(UserConfigFetchConfig());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 240, 219, 1),
      body: BlocListener<UserConfigBloc, UserConfigState>(
        listener: (context, state) {
          Navigator.of(context).pushAndRemoveUntil(
              HomeScreen.route(widget.cameras), (route) => false);
        },
        listenWhen: (previous, current) =>
            previous.isFetching != current.isFetching && !current.isFetching,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/icon/logo.png'),
                height: 200,
                width: 200,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ),
              Text(
                'Setting up...',
                style: TextStyle(
                  fontFamily: 'Allison',
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

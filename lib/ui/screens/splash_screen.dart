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
      body: BlocListener<UserConfigBloc, UserConfigState>(
        listener: (context, state) {
          Navigator.of(context).pushAndRemoveUntil(
              HomeScreen.route(widget.cameras), (route) => false);
        },
        listenWhen: (previous, current) =>
            previous.isFetching != current.isFetching && !current.isFetching,
        child: Center(
          child: Text('Splashhhhhh'),
        ),
      ),
    );
  }
}

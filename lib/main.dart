import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/services/services.dart';
import 'package:project_lyca/ui/screens/screens.dart';
import 'package:project_lyca/constants.dart' as constants;
import 'package:project_lyca/ui/screens/unknown_screen.dart';

void main() async {
  Bloc.observer = AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  if (constants.currentEnvironment == constants.environmentDev) {
    FirebaseFunctions.instance.useFunctionsEmulator(
      origin: constants.functionsEmulatorUrl,
    );
  }

  final cameras = await availableCameras();
  runApp(
    App(
      authenticationService: FirebaseAuthService(),
      dataRepository: FirebaseUserConfigService(),
      camera: cameras,
    ),
  );
}

class App extends StatelessWidget {
  App({
    Key? key,
    required this.authenticationService,
    required this.dataRepository,
    required this.camera,
  }) : super(key: key);

  final AuthService authenticationService;
  final UserConfigService dataRepository;
  final List<CameraDescription> camera;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthService>(
            create: (context) => authenticationService,
          ),
          RepositoryProvider<UserConfigService>(
            create: (context) => dataRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationCubit>(
              create: (_) => AuthenticationCubit(
                  authenticationService: authenticationService),
            ),
            BlocProvider<UserConfigBloc>(
              create: (_) => UserConfigBloc(
                authService: authenticationService,
                userConfigService: dataRepository,
              ),
            )
          ],
          child: AppView(
            navigatorKey: _navigatorKey,
            child: child,
            camera: camera,
          ),
        ),
      ),
      onGenerateRoute: (_) => UnknownScreen.route(),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({required this.navigatorKey, required this.camera, this.child});

  final GlobalKey<NavigatorState> navigatorKey;
  final List<CameraDescription> camera;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          _navigator.pushAndRemoveUntil<void>(
            SplashScreen.route(camera),
            (route) => false,
          );
        } else {
          _navigator.pushAndRemoveUntil<void>(
            LoginScreen.route(),
            (route) => false,
          );
        }
      },
      child: child,
    );
  }

  NavigatorState get _navigator => navigatorKey.currentState!;
}

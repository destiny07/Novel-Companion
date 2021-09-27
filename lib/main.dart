import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';
import 'package:project_lyca/repositories/repositories.dart';
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
      authenticationRepository: FirebaseAuthRepository(),
      dataRepository: FirestoreRepository(),
      camera: cameras,
    ),
  );
}

class App extends StatelessWidget {
  final AuthRepository authenticationRepository;
  final DataRepository dataRepository;
  final List<CameraDescription> camera;

  const App({
    Key? key,
    required this.authenticationRepository,
    required this.dataRepository,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<DataRepository>(
          create: (context) => dataRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
                authenticationRepository: authenticationRepository),
          ),
          BlocProvider<UserConfigBloc>(
            create: (_) => UserConfigBloc(
              authRepository: authenticationRepository,
              dataRepository: dataRepository,
            ),
          )
        ],
        child: AppView(camera: camera),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  final List<CameraDescription> camera;

  const AppView({required this.camera});

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                SplashScreen.route(widget.camera),
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
      },
      onGenerateRoute: (_) => UnknownScreen.route(),
    );
  }
}

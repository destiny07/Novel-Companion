import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_lyca/blocs/login/login_cubit.dart';
import 'package:project_lyca/services/services.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 240, 219, 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: BlocProvider(
            create: (context) {
              return LoginCubit(
                authenticationService:
                    RepositoryProvider.of<AuthService>(context),
              );
            },
            child: BlocListener<LoginCubit, LoginState>(
              listenWhen: (previousState, state) =>
                  previousState.statusMessage != state.statusMessage,
              listener: (context, state) {
                Fluttertoast.showToast(
                  msg: state.statusMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Novel Companion',
                      style: GoogleFonts.workSans(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(131, 104, 83, 1),
                      ),
                    ),
                    _branding(),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _branding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/icon/logo.png'),
          height: 200,
          width: 200,
        ),
        Text(
          'Keep on reading!',
          style: TextStyle(
            fontFamily: 'Allison',
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}

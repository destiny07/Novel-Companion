import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _authenticationRepository;

  ForgotPasswordBloc({required AuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(ForgotPasswordState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {}
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:project_lyca/blocs/models/email.dart';
import 'package:project_lyca/blocs/models/password.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(const RegisterState());

  final AuthRepository _authenticationRepository;

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    }
  }

  RegisterState _mapEmailChangedToState(
    RegisterEmailChanged event,
    RegisterState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    );
  }

  RegisterState _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    RegisterState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    );
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    RegisterState state,
  ) async* {
    await _authenticationRepository.signUpWithEmail(
      state.email.value,
      state.password.value,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:project_lyca/blocs/models/password.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'change_password_state.dart';
part 'change_password_event.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required AuthRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(const ChangePasswordState());

  final AuthRepository _authenticationRepository;

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is ChangePasswordPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is ChangePasswordConfirmPasswordChanged) {
      yield _mapConfirmPasswordChangedToState(event, state);
    } else if (event is ChangePasswordSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  ChangePasswordState _mapPasswordChangedToState(
    ChangePasswordPasswordChanged event,
    ChangePasswordState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.confirmPassword]),
    );
  }

  ChangePasswordState _mapConfirmPasswordChangedToState(
    ChangePasswordConfirmPasswordChanged event,
    ChangePasswordState state,
  ) {
    final password = Password.dirty(event.password);
    if (password.value != state.password.value) {
      return state.copyWith(
          confirmPassword: password, status: FormzStatus.invalid);
    }
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.password]),
    );
  }

  Stream<ChangePasswordState> _mapLoginSubmittedToState(
    ChangePasswordSubmitted event,
    ChangePasswordState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.changePassword(state.password.value);
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}

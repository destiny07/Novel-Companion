import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:project_lyca/blocs/models/email.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _authenticationRepository;

  ForgotPasswordBloc({required AuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(ForgotPasswordState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is ForgotPasswordSubmittedEvent) {
      yield* _mapForgotPasswordSubmittedToState(event, state);
    }
  }

  ForgotPasswordState _mapEmailChangedToState(
    ForgotPasswordEmailChanged event,
    ForgotPasswordState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<ForgotPasswordState> _mapForgotPasswordSubmittedToState(
    ForgotPasswordSubmittedEvent event,
    ForgotPasswordState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.resetPassword(state.email.value);
        yield state.copyWith(
            status: FormzStatus.submissionSuccess, isVerificationSent: true);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}

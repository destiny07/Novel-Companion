import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/async.dart';

part 'resend_verification_event.dart';
part 'resend_verification_state.dart';

class ResendVerificationBloc
    extends Bloc<ResendVerificationEvent, ResendVerificationState> {
  final int duration = 100;
  final int increment = 1;
  CountdownTimer? _countdownTimer;

  ResendVerificationBloc() : super(const ResendVerificationState());

  @override
  Stream<ResendVerificationState> mapEventToState(
      ResendVerificationEvent event) async* {
    if (event is ResendVerificationStarted) {
      yield* _mapResendVerificationStartedToState();
    } else if (event is ResendVerificationCountdownDone) {
      yield* _mapResendVerificationCountdownDoneToState();
    } else if (event is ResendVerificationCountdownUpdated) {
      yield* _mapResendVerificationCountdownUpdatedToState(event);
    }
  }

  Stream<ResendVerificationState> _mapResendVerificationCountdownUpdatedToState(
      ResendVerificationCountdownUpdated event) async* {
    yield ResendVerificationState.countdown(countdownSecsLeft: event.secs);
  }

  Stream<ResendVerificationState>
      _mapResendVerificationStartedToState() async* {
    yield ResendVerificationState.started();
    _startTimer();
  }

  Stream<ResendVerificationState>
      _mapResendVerificationCountdownDoneToState() async* {
    yield ResendVerificationState.done();
  }

  void _startTimer() {
    _countdownTimer = new CountdownTimer(
      Duration(seconds: duration),
      Duration(seconds: increment),
    );

    final sub = _countdownTimer!.listen(null);
    sub.onData((duration) {
      add(ResendVerificationCountdownUpdated(duration.elapsed.inSeconds));
    });
    sub.onDone(() {
      sub.cancel();
      add(ResendVerificationCountdownDone());
    });
  }
}

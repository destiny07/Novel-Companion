part of 'resend_verification_bloc.dart';

class ResendVerificationState extends Equatable {
  final bool isStarted;
  final bool isCountdownDone;
  final int countdownSecsLeft;

  const ResendVerificationState({
    this.isStarted = false,
    this.isCountdownDone = false,
    this.countdownSecsLeft = 100,
  });

  const ResendVerificationState.started({
    this.isStarted = true,
    this.isCountdownDone = false,
    this.countdownSecsLeft = 100,
  });

  const ResendVerificationState.done({
    this.isStarted = false,
    this.isCountdownDone = true,
    this.countdownSecsLeft = 100,
  });

  const ResendVerificationState.countdown({
    this.isStarted = true,
    this.isCountdownDone = false,
    required this.countdownSecsLeft,
  });

  @override
  List<Object?> get props => [isStarted, isCountdownDone, countdownSecsLeft];
}

part of 'resend_verification_bloc.dart';

abstract class ResendVerificationEvent extends Equatable {
  const ResendVerificationEvent();

  @override
  List<Object> get props => [];
}

class ResendVerificationCountdownUpdated extends ResendVerificationEvent {
  final int secs;

  const ResendVerificationCountdownUpdated(this.secs);

  @override
  List<Object> get props => [secs];
}

class ResendVerificationStarted extends ResendVerificationEvent {}

class ResendVerificationCountdownDone extends ResendVerificationEvent {}
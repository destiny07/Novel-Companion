part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordPasswordChanged extends ChangePasswordEvent {
  const ChangePasswordPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class ChangePasswordConfirmPasswordChanged extends ChangePasswordEvent {
  const ChangePasswordConfirmPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  const ChangePasswordSubmitted();
}
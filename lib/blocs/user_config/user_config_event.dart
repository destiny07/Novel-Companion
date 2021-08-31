part of 'user_config_bloc.dart';

abstract class UserConfigEvent extends Equatable {
  const UserConfigEvent();

  @override
  List<Object?> get props => [];
}

class UserConfigUpdateFontSize extends UserConfigEvent {
  final int fontSize;

  const UserConfigUpdateFontSize(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}

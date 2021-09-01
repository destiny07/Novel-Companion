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

class UserConfigUpdateFontStyle extends UserConfigEvent {
  final String fontStyle;

  const UserConfigUpdateFontStyle(this.fontStyle);

  @override
  List<Object?> get props => [fontStyle];
}

class UserConfigUpdateTheme extends UserConfigEvent {
  final String theme;

  const UserConfigUpdateTheme(this.theme);

  @override
  List<Object?> get props => [theme];
}

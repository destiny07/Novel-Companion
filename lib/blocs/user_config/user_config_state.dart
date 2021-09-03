part of 'user_config_bloc.dart';

class UserConfigState extends Equatable {
  final String fontStyle;
  final double fontSize;
  final String theme;

  const UserConfigState({
    required this.fontStyle,
    required this.fontSize,
    required this.theme,
  });

  factory UserConfigState.initial() {
    return UserConfigState(
      fontStyle: constants.latoKey,
      fontSize: 11,
      theme: constants.blueThemeKey,
    );
  }

  UserConfigState copyWith({
    String? fontStyle,
    double? fontSize,
    String? theme,
  }) {
    return UserConfigState(
      fontStyle: fontStyle ?? this.fontStyle,
      fontSize: fontSize ?? this.fontSize,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [fontStyle, fontSize, theme];
}

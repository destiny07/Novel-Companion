part of 'user_config_bloc.dart';

class UserConfigState extends Equatable {
  final String fontStyle;
  final int fontSize;

  const UserConfigState({required this.fontStyle, required this.fontSize});

  factory UserConfigState.initial() {
    return UserConfigState(fontStyle: constants.latoKey, fontSize: 11);
  }

  UserConfigState copyWith({
    String? fontStyle,
    int? fontSize,
  }) {
    return UserConfigState(
      fontStyle: fontStyle ?? this.fontStyle,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [fontStyle, fontSize];
}

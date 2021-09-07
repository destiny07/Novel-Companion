part of 'user_config_bloc.dart';

class UserConfigState extends Equatable {
  final String fontStyle;
  final double fontSize;
  final String theme;
  final bool isFetching;
  final bool isFetchSuccess;
  final bool isSaving;
  final bool isSaveSuccessful;

  const UserConfigState({
    required this.fontStyle,
    required this.fontSize,
    required this.theme,
    this.isFetching = false,
    this.isFetchSuccess = false,
    this.isSaving = false,
    this.isSaveSuccessful = false,
  });

  factory UserConfigState.initial() {
    return UserConfigState(
      fontSize: constants.defaultFontSize,
      fontStyle: constants.defaultFontStyle,
      theme: constants.defaultTheme,
    );
  }

  UserConfigState copyWith({
    String? fontStyle,
    double? fontSize,
    String? theme,
    bool? isFetching,
    bool? isFetchSuccess,
    bool? isSaving,
    bool? isSaveSuccessful,
  }) {
    return UserConfigState(
      fontStyle: fontStyle ?? this.fontStyle,
      fontSize: fontSize ?? this.fontSize,
      theme: theme ?? this.theme,
      isFetching: isFetching ?? this.isFetching,
      isFetchSuccess: isFetchSuccess ?? this.isFetchSuccess,
      isSaving: isSaving ?? this.isSaveSuccessful,
      isSaveSuccessful: isSaveSuccessful ?? this.isSaveSuccessful,
    );
  }

  @override
  List<Object?> get props => [
        fontStyle,
        fontSize,
        theme,
        isFetching,
        isFetchSuccess,
        isSaving,
        isSaveSuccessful,
      ];
}

part of 'user_config_bloc.dart';

class UserConfigState extends Equatable {
  final UserConfig? userConfig;

  const UserConfigState({this.userConfig});

  factory UserConfigState.initial() {
    return UserConfigState(userConfig: UserConfig(fontSize: 11, history: []));
  }

  UserConfigState copyWith({
    UserConfig? userConfig,
  }) {
    return UserConfigState(userConfig: userConfig ?? this.userConfig);
  }

  @override
  List<Object?> get props => [];
}

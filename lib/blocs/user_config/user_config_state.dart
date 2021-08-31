part of 'user_config_bloc.dart';

class UserConfigState extends Equatable {
  final UserConfig? userConfig;

  const UserConfigState._({this.userConfig});

  const UserConfigState.initial() : this._();

  @override
  List<Object?> get props => [];
}

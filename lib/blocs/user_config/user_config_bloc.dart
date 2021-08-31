import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {
  final DataRepository dataRepository;

  UserConfigBloc({required this.dataRepository})
      : super(UserConfigState.initial());

  @override
  Stream<UserConfigState> mapEventToState(UserConfigEvent event) async* {
    if (event is UserConfigUpdateFontSize) {
      yield* _mapUserConfigUpdateFontSizeToState(event);
    }
  }

  Stream<UserConfigState> _mapUserConfigUpdateFontSizeToState(
    UserConfigUpdateFontSize event,
  ) async* {
    UserConfig? userConfig = state.userConfig;

    if (userConfig == null) {
      userConfig = UserConfig(history: [], fontSize: event.fontSize);
    } else {
      userConfig = userConfig.copyWith(fontSize: event.fontSize);
    }

    yield state.copyWith(userConfig: userConfig);
  }
}

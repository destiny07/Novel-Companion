import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';
import 'package:project_lyca/constants.dart' as constants;

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
    } else if (event is UserConfigUpdateFontStyle) {
      yield* _mapUserConfigUpdateFontStyleToState(event);
    }
  }

  Stream<UserConfigState> _mapUserConfigUpdateFontSizeToState(
    UserConfigUpdateFontSize event,
  ) async* {
    yield state.copyWith(fontSize: event.fontSize);
  }

  Stream<UserConfigState> _mapUserConfigUpdateFontStyleToState(
    UserConfigUpdateFontStyle event,
  ) async* {
    yield state.copyWith(fontStyle: event.fontStyle);
  }
}

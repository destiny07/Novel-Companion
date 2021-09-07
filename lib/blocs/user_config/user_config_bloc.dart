import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';
import 'package:project_lyca/constants.dart' as constants;

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {
  final AuthRepository authRepository;
  final DataRepository dataRepository;

  UserConfigBloc({required this.authRepository, required this.dataRepository})
      : super(UserConfigState.initial());

  @override
  Stream<UserConfigState> mapEventToState(UserConfigEvent event) async* {
    if (event is UserConfigUpdateFontSize) {
      yield* _mapUserConfigUpdateFontSizeToState(event);
    } else if (event is UserConfigUpdateFontStyle) {
      yield* _mapUserConfigUpdateFontStyleToState(event);
    } else if (event is UserConfigUpdateTheme) {
      yield* _mapUserConfigUpdateThemeToState(event);
    } else if (event is UserConfigFetchConfig) {
      yield* _mapUserConfigFetchConfig(event);
    }
  }

  Stream<UserConfigState> _mapUserConfigFetchConfig(
    UserConfigEvent event,
  ) async* {
    yield state.copyWith(isFetching: true);

    try {
      // fetching here
      final userId = authRepository.userId!;
      final config = await dataRepository.getUserConfig(userId);

      if (config == null) {
        yield state.copyWith(
          fontSize: constants.defaultFontSize,
          fontStyle: constants.defaultFontStyle,
          theme: constants.defaultTheme,
          isFetching: false,
          isFetchSuccess: true,
        );
      } else {
        yield state.copyWith(
          fontSize: config.fontSize,
          fontStyle: constants.defaultFontStyle,
          theme: constants.defaultTheme,
          isFetching: false,
          isFetchSuccess: true,
        );
      }
    } catch (err) {
      yield state.copyWith(
        fontSize: constants.defaultFontSize,
        fontStyle: constants.defaultFontStyle,
        theme: constants.defaultTheme,
        isFetching: false,
        isFetchSuccess: false,
      );
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

  Stream<UserConfigState> _mapUserConfigUpdateThemeToState(
    UserConfigUpdateTheme event,
  ) async* {
    yield state.copyWith(theme: event.theme);
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/constants.dart' as constants;
import 'package:project_lyca/services/services.dart';

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {
  final AuthService authService;
  final UserConfigService userConfigService;

  UserConfigBloc({required this.authService, required this.userConfigService})
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
      final userId = authService.userId!;
      final config = await userConfigService.getUserConfig(userId);

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
          fontStyle: config.fontStyle,
          theme: config.theme,
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
    yield state.copyWith(isSaving: true);

    try {
      final newConfig = UserConfig(
        fontSize: event.fontSize,
        fontStyle: state.fontStyle,
        theme: state.theme,
      );
      await userConfigService.setUserConfig(authService.userId!, newConfig);
      yield state.copyWith(
        isSaving: false,
        isSaveSuccessful: true,
        fontSize: event.fontSize,
      );
    } catch (err) {
      yield state.copyWith(
        isSaving: false,
        isSaveSuccessful: false,
        fontSize: event.fontSize,
      );
    }
  }

  Stream<UserConfigState> _mapUserConfigUpdateFontStyleToState(
    UserConfigUpdateFontStyle event,
  ) async* {
    yield state.copyWith(isSaving: true);

    try {
      final newConfig = UserConfig(
        fontSize: state.fontSize,
        fontStyle: event.fontStyle,
        theme: state.theme,
      );
      await userConfigService.setUserConfig(authService.userId!, newConfig);
      yield state.copyWith(
        isSaving: false,
        isSaveSuccessful: true,
        fontStyle: event.fontStyle,
      );
    } catch (err) {
      yield state.copyWith(
        isSaving: false,
        isSaveSuccessful: false,
        fontStyle: event.fontStyle,
      );
    }
  }

  Stream<UserConfigState> _mapUserConfigUpdateThemeToState(
    UserConfigUpdateTheme event,
  ) async* {
    yield state.copyWith(isSaving: true);

    try {
      final newConfig = UserConfig(
        fontSize: state.fontSize,
        fontStyle: state.fontStyle,
        theme: event.theme,
      );
      await userConfigService.setUserConfig(authService.userId!, newConfig);
      yield state.copyWith(
        isSaving: false,
        isSaveSuccessful: true,
        theme: event.theme,
      );
    } catch (err) {
      yield state.copyWith(
        isSaving: false,
        isSaveSuccessful: false,
        theme: event.theme,
      );
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/models/models.dart';
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
    yield state.copyWith(isSaving: true);

    try {
      final newConfig = UserConfig(
        fontSize: event.fontSize,
        fontStyle: state.fontStyle,
        theme: state.theme,
      );
      await dataRepository.setUserConfig(authRepository.userId!, newConfig);
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
    final newConfig = UserConfig(
      fontSize: state.fontSize,
      fontStyle: event.fontStyle,
      theme: state.theme,
    );
    await dataRepository.setUserConfig(authRepository.userId!, newConfig);
    yield state.copyWith(fontStyle: event.fontStyle);
  }

  Stream<UserConfigState> _mapUserConfigUpdateThemeToState(
    UserConfigUpdateTheme event,
  ) async* {
    final newConfig = UserConfig(
      fontSize: state.fontSize,
      fontStyle: state.fontStyle,
      theme: event.theme,
    );
    await dataRepository.setUserConfig(authRepository.userId!, newConfig);
    yield state.copyWith(theme: event.theme);
  }
}

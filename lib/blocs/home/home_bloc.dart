import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/services/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DictionaryService dictionaryService;

  HomeBloc({
    required this.dictionaryService,
  }) : super(const HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeToggleSearchBar) {
      yield* _mapHomeToggleSearchBarToState(event);
    } else if (event is HomeTapText) {
      yield* _mapHomeTapTextToState(event);
    } else if (event is HomeSearchWord) {
      yield* _mapHomeSearchWord(event);
    } else if (event is HomeToggleWordInfo) {
      yield* _mapToggleToggleWordInfo(event);
    }
  }

  Stream<HomeState> _mapHomeTapTextToState(HomeTapText event) async* {
    yield state.copyWith(isSearchLoading: true);

    var result = await dictionaryService.searchWord(event.word);

    yield state.copyWith(
      isSearchLoading: false,
      isShowSearchBar: false,
      isShowWordInfo: true,
      word: result,
    );
  }

  Stream<HomeState> _mapHomeSearchWord(HomeSearchWord event) async* {
    yield state.copyWith(isSearchLoading: true, inputWord: event.word);

    var result = await dictionaryService.searchWord(event.word);

    yield state.copyWith(
      isSearchLoading: false,
      isShowSearchBar: false,
      isShowWordInfo: true,
      isManualShowWordInfoToggle: false,
      word: result,
    );
  }

  Stream<HomeState> _mapToggleToggleWordInfo(HomeToggleWordInfo event) async* {
    final isShow = state.isShowWordInfo;

    if (isShow == event.show) {
      return;
    }

    yield state.copyWith(
        isShowWordInfo: event.show, isManualShowWordInfoToggle: true);
  }

  Stream<HomeState> _mapHomeToggleSearchBarToState(
      HomeToggleSearchBar event) async* {
    final currentState = state.isShowSearchBar;
    yield state.copyWith(isShowSearchBar: !currentState, isShowWordInfo: false);
  }
}

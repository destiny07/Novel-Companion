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
    }
  }

  Stream<HomeState> _mapHomeTapTextToState(HomeTapText event) async* {
    var result = await dictionaryService.searchWord(event.word);
    yield state.copyWith(
        isShowSearchBar: false, isShowWordInfo: true, word: result);
  }

  Stream<HomeState> _mapHomeToggleSearchBarToState(
      HomeToggleSearchBar event) async* {
    final currentState = state.isShowSearchBar;
    yield state.copyWith(isShowSearchBar: !currentState, isShowWordInfo: false);
  }
}

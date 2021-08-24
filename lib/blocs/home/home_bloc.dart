import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project_lyca/services/contracts/contracts.dart';

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
    yield state;
  }

  Stream<HomeState> _mapHomeToggleSearchBarToState(
      HomeToggleSearchBar event) async* {
    final currentState = state.isShowSearchBar;
    yield state.copyWith(isShowSearchBar: !currentState);
  }
}

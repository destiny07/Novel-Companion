import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';
import 'package:project_lyca/services/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DictionaryService dictionaryService;
  final DataRepository dataRepository;
  late CancelableCompleter<Word> _searchCompleter;

  HomeBloc({
    required this.dictionaryService,
    required this.dataRepository,
  }) : super(const HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeToggleSearchBar) {
      yield* _mapHomeToggleSearchBarToState(event);
    } else if (event is HomeTapText) {
      yield* _mapHomeTapTextToState(event);
    } else if (event is HomeFetchWord) {
      yield* _mapHomeFetchWord(event);
    } else if (event is HomeSearchWord) {
      yield* _mapHomeSearchWord(event);
    } else if (event is HomeToggleWordInfo) {
      yield* _mapToggleToggleWordInfo(event);
    } else if (event is HomeToggleTts) {
      yield* _mapHomeToggleTtsToState(event);
    } else if (event is HomePermissionsUpdated) {
      yield* _mapHomePermissionsUpdated(event);
    } else if (event is HomeToggleTorch) {
      yield* _mapHomeToggleTorch(event);
    } else if (event is HomeProcessing) {
      yield* _mapHomeProcessing(event);
    } else if (event is HomeCancelSearchWord) {
      yield* _mapHomeCancelSearchWord(event);
    } else if (event is HomeCancelCompleter) {
      yield* _mapHomeProcessing(HomeProcessing(false));
    }
  }

  Stream<HomeState> _mapHomeTapTextToState(HomeTapText event) async* {
    _searchCompleter = CancelableCompleter(
      onCancel: () {
        add(HomeCancelCompleter());
      },
    );
    _searchCompleter.complete(dictionaryService.searchWord(event.word));

    yield state.copyWith(isSearchLoading: true);

    _searchCompleter.operation.value.then((result) {
      add(HomeFetchWord(result));
    });
  }

  Stream<HomeState> _mapHomeFetchWord(HomeFetchWord event) async* {
    yield state.copyWith(
      isSearchLoading: false,
      isShowSearchBar: false,
      isShowWordInfo: true,
      word: event.word,
    );
  }

  Stream<HomeState> _mapHomeCancelSearchWord(
    HomeCancelSearchWord event,
  ) async* {
    await _searchCompleter.operation.cancel();
  }

  Stream<HomeState> _mapHomeProcessing(HomeProcessing event) async* {
    yield state.copyWith(isSearchLoading: event.isProcessing);
  }

  Stream<HomeState> _mapHomeSearchWord(HomeSearchWord event) async* {
    _searchCompleter = CancelableCompleter(
      onCancel: () {
        add(HomeCancelCompleter());
      },
    );
    _searchCompleter.complete(dictionaryService.searchWord(event.word));

    yield state.copyWith(isShowSearchBar: false, isSearchLoading: true);

    _searchCompleter.operation.value.then((result) {
      add(HomeFetchWord(result));
    });
  }

  Stream<HomeState> _mapToggleToggleWordInfo(HomeToggleWordInfo event) async* {
    final isShow = state.isShowWordInfo;

    if (isShow == event.show) {
      return;
    }

    yield state.copyWith(isShowWordInfo: event.show);
  }

  Stream<HomeState> _mapHomeToggleSearchBarToState(
      HomeToggleSearchBar event) async* {
    final currentState = state.isShowSearchBar;
    yield state.copyWith(isShowSearchBar: !currentState, isShowWordInfo: false);
  }

  Stream<HomeState> _mapHomeToggleTtsToState(HomeToggleTts event) async* {
    yield state.copyWith(isTtsReading: event.isStart);
  }

  Stream<HomeState> _mapHomePermissionsUpdated(
    HomePermissionsUpdated event,
  ) async* {
    yield state.copyWith(hasPermissions: event.hasPermissions);
  }

  Stream<HomeState> _mapHomeToggleTorch(HomeToggleTorch event) async* {
    final isTorchOn = state.isTorchOn;
    yield state.copyWith(isTorchOn: !isTorchOn);
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/services/contracts/contracts.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DictionaryService dictionaryService;
  final ITorchService torchService;

  HomeBloc({required this.dictionaryService, required this.torchService})
      : super(const HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeToggleSearchBar) {
      yield* _mapHomeToggleSearchBarToState(event);
    } else if (event is HomeToggleTorch) {
      yield* _mapHomeToggleTorchToState(event);
    }
  }

  Stream<HomeState> _mapHomeToggleSearchBarToState(
      HomeToggleSearchBar event) async* {
    final currentState = state.isShowSearchBar;
    yield state.copyWith(isShowSearchBar: !currentState);
  }

  Stream<HomeState> _mapHomeToggleTorchToState(HomeToggleTorch event) async* {
    if (event.turnOn) {
      torchService.turnOn();
    } else {
      torchService.turnOff();
    }

    yield state.copyWith(isTorchOn: event.turnOn);
  }
}

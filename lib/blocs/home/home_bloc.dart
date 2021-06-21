import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project_lyca/services/contracts/contracts.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DictionaryService dictionaryService;
  final IMlService mlService;
  final ITorchService torchService;

  HomeBloc({
    required this.dictionaryService,
    required this.mlService,
    required this.torchService,
  }) : super(const HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeToggleSearchBar) {
      yield* _mapHomeToggleSearchBarToState(event);
    } else if (event is HomeToggleTorch) {
      yield* _mapHomeToggleTorchToState(event);
    } else if (event is HomeTapText) {
      yield* _mapHomeTapTextToState(event);
    }
  }

  Stream<HomeState> _mapHomeTapTextToState(HomeTapText event) async* {
    print('x: ${event.x}, y: ${event.y}');
    var touchRect =
        Rect.fromCenter(center: Offset(event.x, event.y), width: 1, height: 1);
    mlService.getTextFromImage(event.path, touchRect);
    yield state;
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

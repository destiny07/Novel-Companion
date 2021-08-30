part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeTapText extends HomeEvent {
  final String word;

  const HomeTapText(this.word);

  @override
  List<Object> get props => [word];
}

class HomeSearchWord extends HomeEvent {
  final String word;

  const HomeSearchWord(this.word);

  @override
  List<Object> get props => [word];
}

class HomeToggleSearchBar extends HomeEvent {
  const HomeToggleSearchBar();
}

class HomeToggleTorch extends HomeEvent {
  final bool turnOn;

  const HomeToggleTorch(this.turnOn);

  @override
  List<Object> get props => [turnOn];
}

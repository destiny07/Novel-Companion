part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeTapText extends HomeEvent {
  final InputImage path;
  final double x;
  final double y;
  const HomeTapText(this.path, this.x, this.y);

  @override
  List<Object> get props => [path, x, y];
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

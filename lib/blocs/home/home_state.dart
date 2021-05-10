part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isShowSearchBar;

  const HomeState({this.isShowSearchBar = false});

  HomeState copyWith({bool? isShowSearchBar}) {
    return HomeState(isShowSearchBar: isShowSearchBar ?? this.isShowSearchBar);
  }

  @override
  List<Object> get props => [isShowSearchBar];
}

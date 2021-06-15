part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isShowSearchBar;
  final bool isTorchOn;

  const HomeState({this.isShowSearchBar = false, this.isTorchOn = false});

  HomeState copyWith({
    bool? isShowSearchBar,
    bool? isTorchOn,
  }) {
    return HomeState(
      isShowSearchBar: isShowSearchBar ?? this.isShowSearchBar,
      isTorchOn: isTorchOn ?? this.isTorchOn,
    );
  }

  @override
  List<Object> get props => [isShowSearchBar];
}

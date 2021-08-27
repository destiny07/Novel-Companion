part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isShowSearchBar;
  final bool isShowWordInfo;
  final bool isTorchOn;
  final Word? word;

  const HomeState({
    this.isShowSearchBar = false,
    this.isShowWordInfo = false,
    this.isTorchOn = false,
    this.word
  });

  HomeState copyWith({
    bool? isShowSearchBar,
    bool? isShowWordInfo,
    bool? isTorchOn,
    Word? word,
  }) {
    return HomeState(
      isShowSearchBar: isShowSearchBar ?? this.isShowSearchBar,
      isShowWordInfo: isShowWordInfo ?? this.isShowWordInfo,
      isTorchOn: isTorchOn ?? this.isTorchOn,
      word: word ?? this.word,
    );
  }

  @override
  List<Object?> get props => [isShowSearchBar, isShowWordInfo, isTorchOn, word];
}

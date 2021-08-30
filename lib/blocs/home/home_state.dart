part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isShowSearchBar;
  final bool isShowWordInfo;
  final bool isTorchOn;
  final bool isSearchLoading;
  final Word? word;

  const HomeState({
    this.isShowSearchBar = false,
    this.isShowWordInfo = false,
    this.isTorchOn = false,
    this.isSearchLoading = false,
    this.word,
  });

  HomeState copyWith({
    bool? isShowSearchBar,
    bool? isShowWordInfo,
    bool? isTorchOn,
    bool? isSearchLoading,
    Word? word,
  }) {
    return HomeState(
      isShowSearchBar: isShowSearchBar ?? this.isShowSearchBar,
      isShowWordInfo: isShowWordInfo ?? this.isShowWordInfo,
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      word: word ?? this.word,
    );
  }

  @override
  List<Object?> get props => [
        isShowSearchBar,
        isShowWordInfo,
        isTorchOn,
        isSearchLoading,
        word,
      ];
}

part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isShowSearchBar;
  final bool isShowWordInfo;
  final bool isTorchOn;
  final bool isSearchLoading;
  final bool isTtsReading;
  final bool hasPermissions;
  final bool isPermanentlyDeniedPermissions;
  final String? inputWord;
  final Word? word;

  const HomeState({
    this.isShowSearchBar = false,
    this.isShowWordInfo = false,
    this.isTorchOn = false,
    this.isSearchLoading = false,
    this.isTtsReading = false,
    this.hasPermissions = false,
    this.isPermanentlyDeniedPermissions = false,
    this.inputWord,
    this.word,
  });

  HomeState copyWith({
    bool? isShowSearchBar,
    bool? isShowWordInfo,
    bool? isTorchOn,
    bool? isSearchLoading,
    bool? isTtsReading,
    String? inputWord,
    Word? word,
    bool? hasPermissions,
    bool? isPermanentlyDeniedPermissions,
  }) {
    return HomeState(
      isShowSearchBar: isShowSearchBar ?? this.isShowSearchBar,
      isShowWordInfo: isShowWordInfo ?? this.isShowWordInfo,
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      isTtsReading: isTtsReading ?? this.isTtsReading,
      inputWord: inputWord ?? this.inputWord,
      word: word ?? this.word,
      hasPermissions: hasPermissions ?? this.hasPermissions,
      isPermanentlyDeniedPermissions:
          isPermanentlyDeniedPermissions ?? this.isPermanentlyDeniedPermissions,
    );
  }

  @override
  List<Object?> get props => [
        isShowSearchBar,
        isShowWordInfo,
        isTorchOn,
        isSearchLoading,
        isTtsReading,
        inputWord,
        word,
        hasPermissions,
        isPermanentlyDeniedPermissions,
      ];
}

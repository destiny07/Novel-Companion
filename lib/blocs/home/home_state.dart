part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isShowSearchBar;
  final bool isShowWordInfo;
  final bool isManualShowWordInfoToggle;
  final bool isTorchOn;
  final bool isSearchLoading;
  final String? inputWord;
  final Word? word;

  const HomeState({
    this.isShowSearchBar = false,
    this.isShowWordInfo = false,
    this.isManualShowWordInfoToggle = false,
    this.isTorchOn = false,
    this.isSearchLoading = false,
    this.inputWord,
    this.word,
  });

  HomeState copyWith({
    bool? isShowSearchBar,
    bool? isShowWordInfo,
    bool? isManualShowWordInfoToggle,
    bool? isTorchOn,
    bool? isSearchLoading,
    String? inputWord,
    Word? word,
  }) {
    return HomeState(
      isShowSearchBar: isShowSearchBar ?? this.isShowSearchBar,
      isShowWordInfo: isShowWordInfo ?? this.isShowWordInfo,
      isManualShowWordInfoToggle:
          isManualShowWordInfoToggle ?? this.isManualShowWordInfoToggle,
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      inputWord: inputWord ?? this.inputWord,
      word: word ?? this.word,
    );
  }

  @override
  List<Object?> get props => [
        isShowSearchBar,
        isShowWordInfo,
        isTorchOn,
        isSearchLoading,
        inputWord,
        word,
      ];
}

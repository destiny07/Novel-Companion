part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeTapText extends HomeEvent {
  // final Size screenResolution;
  final InputImage inputImage;
  final Offset offset;

  const HomeTapText({
    // required this.screenResolution,
    required this.inputImage,
    required this.offset,
  });

  @override
  List<Object> get props => [inputImage, offset];
}

class HomeShowTapAgain extends HomeEvent {
  const HomeShowTapAgain();

  @override
  List<Object> get props => [];
}

class HomeFetchWord extends HomeEvent {
  final bool isSuccess;
  final String? description;
  final Word? word;
  final String inputWord;

  const HomeFetchWord({
    required this.inputWord,
    this.isSuccess = true,
    this.description,
    this.word,
  });

  @override
  List<Object?> get props => [isSuccess, description, word];
}

class HomeProcessing extends HomeEvent {
  final bool isProcessing;

  const HomeProcessing(this.isProcessing);

  @override
  List<Object> get props => [isProcessing];
}

class HomeSearchWord extends HomeEvent {
  final String word;

  const HomeSearchWord(this.word);

  @override
  List<Object> get props => [word];
}

class HomeCancelSearchWord extends HomeEvent {
  const HomeCancelSearchWord();

  @override
  List<Object> get props => [];
}

class HomeCancelCompleter extends HomeEvent {
  const HomeCancelCompleter();

  @override
  List<Object> get props => [];
}

class HomeToggleWordInfo extends HomeEvent {
  final bool show;
  const HomeToggleWordInfo(this.show);
}

class HomeToggleSearchBar extends HomeEvent {
  const HomeToggleSearchBar();
}

class HomeToggleTorch extends HomeEvent {
  const HomeToggleTorch();

  @override
  List<Object> get props => [];
}

class HomeToggleTts extends HomeEvent {
  final bool isStart;

  const HomeToggleTts(this.isStart);

  @override
  List<Object> get props => [isStart];
}

class HomePermissionsUpdated extends HomeEvent {
  final bool hasPermissions;

  const HomePermissionsUpdated(this.hasPermissions);

  @override
  List<Object> get props => [hasPermissions];
}

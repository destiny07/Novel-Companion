import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/ui/screens/home/word_info.dart';

class AnimatedWordInfo extends StatefulWidget {
  final Function(bool) onVisibilityChanged;

  AnimatedWordInfo({required this.onVisibilityChanged});

  @override
  State<StatefulWidget> createState() => _AnimatedWordInfo();
}

class _AnimatedWordInfo extends State<AnimatedWordInfo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-2.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: _wordInfo(),
      ),
    );
  }

  Widget _wordInfo() {
    return BlocListener<HomeBloc, HomeState>(
      listener: (previous, current) {
        if (current.isShowWordInfo) {
          _controller.reverse();
          widget.onVisibilityChanged(true);
        } else {
          _controller.forward();
          widget.onVisibilityChanged(false);
        }
      },
      listenWhen: (previous, current) => current.isManualShowWordInfoToggle,
      child: SlideTransition(
        position: _offsetAnimation,
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => previous.word != current.word,
          builder: (context, state) {
            if (state.isShowWordInfo) {
              return WordInfo(word: state.word!);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

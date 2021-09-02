import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';

class SearchBar extends StatefulWidget {
  final Function(bool) onVisibilityChanged;

  SearchBar({required this.onVisibilityChanged});

  @override
  State<StatefulWidget> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(0.0, -2.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (previous, current) {
        if (current.isShowSearchBar) {
          _controller.forward();
          widget.onVisibilityChanged(true);
          _focusNode.requestFocus();
        } else {
          _controller.reverse();
          widget.onVisibilityChanged(false);
          FocusScope.of(context).unfocus();
        }
      },
      listenWhen: (previous, current) =>
          previous.isShowSearchBar != current.isShowSearchBar,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: _textField(),
          ),
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget _textField() {
    return TextField(
      focusNode: _focusNode,
      cursorColor: Theme.of(context).textTheme.bodyText1!.color,
      style: TextStyle(
        fontSize: 25.0,
        color: Theme.of(context).textTheme.bodyText1!.color,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: Icon(Icons.search,
            color: Theme.of(context).textTheme.bodyText1!.color),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).backgroundColor, width: 32.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
      ),
      onSubmitted: (value) {
        BlocProvider.of<HomeBloc>(context).add(HomeSearchWord(value.trim()));
      },
    );
  }
}

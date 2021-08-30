import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/blocs/blocs.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -2.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (previous, current) {
        if (current.isShowSearchBar) {
          _controller.reverse();
        } else {
          _controller.forward();
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
            color: Colors.white,
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
      autofocus: true,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.blueAccent,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: Icon(Icons.search),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 32.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onSubmitted: (value) {
        BlocProvider.of<HomeBloc>(context).add(HomeSearchWord(value.trim()));
      },
    );
  }
}

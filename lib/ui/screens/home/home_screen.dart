import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/services/services.dart';
import 'package:project_lyca/ui/screens/home/action_bar.dart';
import 'package:project_lyca/ui/screens/home/camera_view.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  static Route route(List<CameraDescription> cameras) {
    return MaterialPageRoute<void>(
        builder: (_) => HomeScreen(
              cameras: cameras,
            ));
  }

  const HomeScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.settings),
      //       color: Colors.white,
      //       onPressed: () {
      //         Navigator.of(context).push(SettingsScreen.route());
      //       },
      //     ),
      //   ],
      // ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: BlocProvider(
            create: (context) {
              return HomeBloc(
                dictionaryService: FirebaseDictionaryService(),
                torchService: TorchService(),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                CameraView(cameras: widget.cameras),
                // Container(
                //   alignment: Alignment.topCenter,
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 8.0),
                //     child: WordSearchResultCarousel(),
                //   ),
                // ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ActionBar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isShowSearchBar != current.isShowSearchBar,
      builder: (context, state) {
        if (state.isShowSearchBar) {
          return _searchBar(context);
        }
        return Container();
      },
    );
  }

  Widget _searchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: ListView(
              shrinkWrap: true,
              children: Colors.accents.take(2).map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

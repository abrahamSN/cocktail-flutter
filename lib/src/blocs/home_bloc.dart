import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../util/type_data.dart';

class HomeProvider extends InheritedWidget {
  final HomeBloc bloc;

  HomeProvider({Key key, Widget child})
      : bloc = HomeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static HomeBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<HomeProvider>()).bloc;
  }
}

class HomeBloc {
  final _navItem = PublishSubject<NavBarItem>();

  Stream<NavBarItem> get navItem => _navItem.stream;

  NavBarItem defaultItem = NavBarItem.EXPLORE;

  void pickItem(int i) {
    switch(i) {
      case 0:
        _navItem.sink.add(NavBarItem.EXPLORE);
        break;
      case 1:
        _navItem.sink.add(NavBarItem.SEARCH);
        break;
    }
  }

  dispose() {
    _navItem.close();
  }
}

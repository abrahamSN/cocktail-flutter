import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './navbar_event.dart';
import './navbar_state.dart';

import '../../util/type_data.dart';

export './navbar_event.dart';
export './navbar_state.dart';

/// {@template counter_bloc}
/// A simple [Bloc] which manages a `Navigation Bar` as its state.
/// {@endtemplate}
class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(ChangePage(index: 0, navbarItem: NavbarItem.EXPLORE));

  @override
  Stream<NavbarState> mapEventToState(NavbarEvent event) async* {
    if (event is PickItem) {
      switch (event.props[0]) {
        case 0:
          yield ChangePage(
            index: 0,
            navbarItem: NavbarItem.EXPLORE,
          );
          break;
        case 1:
          yield ChangePage(
            index: 1,
            navbarItem: NavbarItem.CHAT,
          );
          break;
        case 2:
          yield ChangePage(
            index: 2,
            navbarItem: NavbarItem.ACCOUNT,
          );
          break;
      }
    }
  }
}

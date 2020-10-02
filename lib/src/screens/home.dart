import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './accounts/account.dart';
import './explores/explore.dart';
import './messages/message.dart';

import '../blocs/blocs.dart';
import '../util/type_data.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavbarBloc _navbarBloc = BlocProvider.of<NavbarBloc>(context);

    return Scaffold(
      body: _bodyBuilder(_navbarBloc),
      bottomNavigationBar: _btmNav(_navbarBloc),
    );
  }

  Widget _bodyBuilder(NavbarBloc _navbarBloc) {
    final FirebaseAuth _fbAuth = FirebaseAuth.instance;
    return BlocBuilder<NavbarBloc, NavbarState>(
      cubit: _navbarBloc,
      // ignore: missing_return
      builder: (BuildContext context, NavbarState state) {
        if (state is ChangePage) {
          switch (state.props[1]) {
            case NavbarItem.EXPLORE:
              context.bloc<CocktailBloc>().add(CocktailFetching());
              return Explore();
              break;
            case NavbarItem.CHAT:
              context.bloc<MessageBloc>().add(MessageFetching(uid: _fbAuth.currentUser.uid));
              return Message();
              break;
            case NavbarItem.ACCOUNT:
              return Account();
              break;
            default:
              return Container();
              break;
          }
        }
        return Container();
      },
    );
  }

  Widget _btmNav(NavbarBloc _navbarBloc) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      cubit: _navbarBloc,
      builder: (BuildContext context, NavbarState state) {
        if (state is ChangePage) {
          return BottomNavigationBar(
            onTap: (i) {
              context.bloc<NavbarBloc>().add(PickItem(index: i));
            },
            currentIndex: state.props[0],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_rounded),
                label: 'Account',
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

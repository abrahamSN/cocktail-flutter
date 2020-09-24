import 'package:cocktail_flutter/src/blocs/blocs.dart';
import 'package:cocktail_flutter/src/util/type_data.dart';
import 'package:flutter/material.dart';

import './counter/counter.dart';
import './explores/explore.dart';
import './search/search.dart';

import '../blocs/explore_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = HomeProvider.of(context);
    final eBloc = ExploreProvider.of(context);

    return Scaffold(
      body: _bodyBuilder(bloc, eBloc),
      bottomNavigationBar: _btmNav(bloc),
    );
  }

  Widget _bodyBuilder(HomeBloc bloc, ExploreBloc eBloc) {
    return StreamBuilder(
      stream: bloc.navItem,
      initialData: bloc.defaultItem,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.data) {
          case NavBarItem.EXPLORE:
            eBloc.fetchAllData('a');
            return Explore();
            break;
          case NavBarItem.SEARCH:
            eBloc.fetchAllData('a');
            return Search();
            break;
          case NavBarItem.COUNTER:
            return Counter();
            break;
        }
      },
    );
  }

  Widget _btmNav(HomeBloc bloc) {
    return StreamBuilder(
      stream: bloc.navItem,
      initialData: bloc.defaultItem,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return BottomNavigationBar(
          onTap: bloc.pickItem,
          currentIndex: snapshot.data.index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Counter',
            ),
          ],
        );
      },
    );
  }
}

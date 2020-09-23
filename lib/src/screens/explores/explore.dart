import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../blocs/explore_bloc.dart';
import '../../models/drink_model.dart';
import '../../widgets/drink_container.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ExploreProvider.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(),
          _listCocktail(bloc),
        ],
      ),
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      centerTitle: true,
      title: Text('Cocktail Flutter'),
      primary: true,
      floating: debugInstrumentationEnabled,
    );
  }

  Widget _listCocktail(ExploreBloc bloc) {
    return StreamBuilder(
      stream: bloc.cocktailList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (!snapshot.hasData) {
                  return Text('loading lah cok');
                }

                final drinkModel = DrinkModel.fromJson(snapshot.data[index]);
                return DrinkContainer(
                  model: drinkModel,
                );
              },
              childCount: snapshot.hasData ? snapshot.data.length : 20,
            ),
          ),
        );
      },
    );
  }
}

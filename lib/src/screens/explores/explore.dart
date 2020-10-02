import 'package:cocktail_flutter/src/data/model/cocktail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final CocktailBloc _cocktailBloc = BlocProvider.of<CocktailBloc>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(),
          _listCocktail(
            media,
            _cocktailBloc,
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      centerTitle: true,
      title: Text(
        'Cocktail Flutter',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      primary: true,
      pinned: true,
      floating: true,
    );
  }

  Widget _listCocktail(MediaQueryData media, CocktailBloc _cocktailBloc) {
    return BlocListener<CocktailBloc, CocktailState>(
      cubit: _cocktailBloc,
      listener: (BuildContext context, CocktailState state) {
        if (state is CocktailFetchError) {
          print(state.error.toString());

          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<CocktailBloc, CocktailState>(
        cubit: _cocktailBloc,
        builder: (BuildContext context, CocktailState state) {
          int _count = 10;

          if (state is CocktailFetchSuccess) {
            _count = state.cocktailModel.drinks.length;
          }

          return SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    media.orientation == Orientation.portrait ? 2 : 4,
              ),
              delegate: SliverChildBuilderDelegate(
                // ignore: missing_return
                (BuildContext context, int index) {
                  if (state is CocktailFetchLoading) {
                    return SkeletonAnimation(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    );
                  }

                  if (state is CocktailFetchSuccess) {
                    final DrinkModel drinkModel =
                        state.cocktailModel.drinks[index];
                    return DrinkContainer(
                      model: drinkModel,
                    );
                  }
                },
                childCount: _count,
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../models/models.dart';
import '../../blocs/blocs.dart';
import '../../widgets/drink_container.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ExploreProvider.of(context);
    return Scaffold(
      body: _bodyBuilder(bloc),
    );
  }

  Widget _bodyBuilder(ExploreBloc bloc) {
    return CustomScrollView(
      slivers: [
        _appBar(bloc),
        _listSearch(bloc),
      ],
    );
  }

  Widget _appBar(ExploreBloc bloc) {
    return SliverAppBar(
      title: TextField(
        onChanged: bloc.fetchAllData,
        autofocus: true,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter Cocktail name...',
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _listSearch(ExploreBloc bloc) {
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

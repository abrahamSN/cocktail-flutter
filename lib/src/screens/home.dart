import 'package:flutter/material.dart';

import './explores/explore.dart';

import '../blocs/explore_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ExploreProvider.of(context);
    bloc.fetchAllData();

    return Scaffold(
      body: Explore(),
    );
  }
}

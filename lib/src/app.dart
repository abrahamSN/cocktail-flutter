import 'package:flutter/material.dart';

import './blocs/explore_bloc.dart';
import './screens/home.dart';
import './screens/details/drink_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExploreProvider(
      child: MaterialApp(
        title: 'Cocktail Flutter',
        initialRoute: '/',
        // theme: ThemeData(
        // primaryColor: Colors.cyanAccent,
        // ),
        routes: {
          '/': (context) => Home(),
          '/drink_detail': (context) => DrinkDetails(),
        },
      ),
    );
  }
}

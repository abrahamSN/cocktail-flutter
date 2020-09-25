import 'package:flutter/material.dart';

import './blocs/blocs.dart';
import './screens/home.dart';
import './screens/details/drink_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: ExploreProvider(
        child: CounterProvider(
          child: MaterialApp(
            title: 'Cocktail Flutter',
            initialRoute: '/',
            routes: {
              '/': (context) => Home(),
              '/drink_detail': (context) => DrinkDetails(),
            },
          ),
        ),
      ),
    );
  }
}

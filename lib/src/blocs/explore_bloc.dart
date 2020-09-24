import 'dart:io';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../resources/api/cocktail_api_provider.dart';

class ExploreProvider extends InheritedWidget {
  final ExploreBloc bloc;

  // make construct of bloc provider
  ExploreProvider({Key key, Widget child})
      : bloc = ExploreBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  // make bloc to be inherited widget
  static ExploreBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ExploreProvider>()).bloc;
  }
}

class ExploreBloc {
  // add api repository
  final _cocktailRepo = CocktailApiProvider();

  // make publish subject to contain stream
  final _cocktailList = PublishSubject<List>();
  final _cocktailRandom = PublishSubject<List>();

  // getter to stream
  Stream<List> get cocktailList => _cocktailList.stream;

  // function to get all data
  fetchAllData(String cocktail) async {
    final cocktailList = await _cocktailRepo.fetchList(cocktail);

    // put the data into stream
    return _cocktailList.sink.add(cocktailList);
  }

  // function to launch youtube
  launchYt(String url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  // close all open stream
  dispose() {
    _cocktailList.close();
    _cocktailRandom.close();
  }
}

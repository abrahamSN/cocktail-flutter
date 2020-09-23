import 'dart:io';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../resources/api/cocktail_api_provider.dart';

class ExploreProvider extends InheritedWidget {
  final ExploreBloc bloc;

  ExploreProvider({Key key, Widget child})
      : bloc = ExploreBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static ExploreBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ExploreProvider>()).bloc;
  }
}

class ExploreBloc {
  final _cocktailRepo = CocktailApiProvider();

  final _cocktailList = PublishSubject<List>();
  final _cocktailRandom = PublishSubject<List>();

  // getter to stream
  Stream<List> get cocktailList => _cocktailList.stream;

  fetchAllData() async {
    final cocktailList = await _cocktailRepo.fetchList();

    return _cocktailList.sink.add(cocktailList);
  }

  launchYt(String url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
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

  dispose() {
    _cocktailList.close();
    _cocktailRandom.close();
  }
}

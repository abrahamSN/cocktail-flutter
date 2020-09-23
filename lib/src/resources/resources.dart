import 'dart:async';

import '../models/models.dart';

export './api/cocktail_api_provider.dart';

abstract class Source {
  Future<List> fetchList();
}

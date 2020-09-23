import 'package:dio/dio.dart';

class ApiClient {
  static const baseUrl = 'www.thecocktaildb.com';
  static const apiPath = 'api/json/v1/1/';

  Dio dio = Dio();

  Future<Response> get(String path) async {
    final url = 'https://$baseUrl/$apiPath/$path';

    try {
      Response res = await dio.get(url);

      return res;
    } catch(e) {
      print(e);
    }
  }
}

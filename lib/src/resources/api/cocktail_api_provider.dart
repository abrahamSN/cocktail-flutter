import '../resources.dart';

import '../../util/api_client.dart';

class CocktailApiProvider implements Source {
  ApiClient apiClient = ApiClient();

  @override
  Future<List> fetchList(String param) async {
    // TODO: implement fetchList
    Map<String, dynamic> data = {
      'path': 'search.php',
      'queryParam': {
        's': param,
      },
    };

    final res = await apiClient.get(data);

    return res.data['drinks'];
  }
}

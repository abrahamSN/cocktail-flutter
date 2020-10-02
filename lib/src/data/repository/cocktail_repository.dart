import '../model/model.dart';

import '../../util/api_client.dart';

class CocktailRepository {
  ApiClient apiClient = ApiClient();

  Future<CocktailModel> getAll() async {
    try {
      Map<String, dynamic> data = {
        'path': 'search.php',
        'queryParam': {
          's': 'a',
        },
      };

      final res = await apiClient.get(data);

      return CocktailModel.fromJson(res.data);
    } catch(e) {
      return e;
    }
  }
}
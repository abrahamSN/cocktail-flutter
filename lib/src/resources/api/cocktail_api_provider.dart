import '../resources.dart';

import '../../models/drink_model.dart';
import '../../util/api_client.dart';

class CocktailApiProvider implements Source {
  ApiClient apiClient = ApiClient();

  @override
  Future<List> fetchList() async {
    // TODO: implement fetchList
    final path = 'search.php?s=a&s=b&s=c&s=d&s=e&s=f&s=d';

    final res = await apiClient.get(path);

    return res.data['drinks'];
  }
}
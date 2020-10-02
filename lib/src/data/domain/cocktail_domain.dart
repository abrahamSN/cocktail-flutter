import '../repository/repository.dart';

class CocktailDomain {
  final CocktailRepository cocktailRepository = CocktailRepository();

  Future getAll() {
    return cocktailRepository.getAll();
  }
}

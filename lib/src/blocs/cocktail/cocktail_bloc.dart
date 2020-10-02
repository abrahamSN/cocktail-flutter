import 'package:bloc/bloc.dart';

import './cocktail_event.dart';
import './cocktail_state.dart';

import '../../data/domain/domain.dart';
import '../../data/model/model.dart';

export './cocktail_event.dart';
export './cocktail_state.dart';

/// {@template counter_bloc}
/// A simple [Bloc] which manages a `CocktailDb` as its state.
/// {@endtemplate}
class CocktailBloc extends Bloc<CocktailEvent, CocktailState> {
  final CocktailDomain cocktailDomain = CocktailDomain();

  CocktailBloc() : super(CocktailFetchLoading());

  @override
  Stream<CocktailState> mapEventToState(CocktailEvent event) async* {
    if (event is CocktailFetching) {
      yield CocktailFetchLoading();

      try {
        CocktailModel cocktailModel = await cocktailDomain.getAll();
        yield CocktailFetchSuccess(cocktailModel: cocktailModel);
      } catch (e) {
        yield CocktailFetchError(error: e.toString());
      }
    }
  }
}

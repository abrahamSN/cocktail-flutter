import 'package:equatable/equatable.dart';

import '../../data/model/model.dart';

abstract class CocktailState extends Equatable {
  const CocktailState();
}

class CocktailFetchLoading extends CocktailState {
  @override
  List<Object> get props => [];
}

class CocktailFetchSuccess extends CocktailState {
  final CocktailModel cocktailModel;

  const CocktailFetchSuccess({this.cocktailModel});

  @override
  List<Object> get props => [cocktailModel];
}

class CocktailFetchError extends CocktailState {
  final String error;

  const CocktailFetchError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Something wrongs: { error: $error }';
}

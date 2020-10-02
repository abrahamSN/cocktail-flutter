import 'package:equatable/equatable.dart';

abstract class CocktailEvent extends Equatable {
  const CocktailEvent();
}

class CocktailFetching extends CocktailEvent {
  @override
  List<Object> get props => [];
}

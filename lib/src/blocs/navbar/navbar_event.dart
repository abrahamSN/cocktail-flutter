import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class NavbarEvent extends Equatable {}

class PickItem extends NavbarEvent {
  final int index;

  PickItem({@required this.index});

  @override
  List<Object> get props => [index];
}
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../util/type_data.dart';

abstract class NavbarState extends Equatable {
  const NavbarState();
}

class LoadPage extends NavbarState {
  @override
  List<Object> get props => [];
}

class ChangePage extends NavbarState {
  final int index;
  final NavbarItem navbarItem;

  ChangePage({@required this.index, @required this.navbarItem});

  @override
  List<Object> get props => [index, navbarItem];
}

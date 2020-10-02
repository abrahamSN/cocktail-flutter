import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggedOut';
}
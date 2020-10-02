import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
}

class UnInitialized extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  String toString() => 'Uninitialized';
}

class AuthenticatedButNotSet extends AuthState {
  final User user;

  AuthenticatedButNotSet(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated: { user: $user }';
}

class UnAuthenticated extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  String toString() => 'UnAuthenticated';
}

class ErrorAuthenticated extends AuthState {
  final String msg;

  ErrorAuthenticated({this.msg});

  @override
  List<Object> get props => [msg];

  @override
  String toString() {
    return 'ErrorAuthenticated: { message : $msg }';
  }
}
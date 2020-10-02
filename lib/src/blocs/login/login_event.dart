import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginWithGooglePressed';
}
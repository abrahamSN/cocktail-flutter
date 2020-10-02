import 'package:meta/meta.dart';

class LoginState {
  final bool isSuccess;
  final bool isFailure;

  LoginState({
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory LoginState.failure() {
    return LoginState(
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isSuccess: true,
      isFailure: false,
    );
  }
}

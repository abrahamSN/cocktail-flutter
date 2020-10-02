import '../repository/repository.dart';

class UserDomain {
  final AuthRepository _authRepository = AuthRepository();

  Future signInWithGoogle() {
    return _authRepository.signInWithGoogle();
  }
}
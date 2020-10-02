import '../repository/repository.dart';

class AuthDomain {
  final AuthRepository _authRepository = AuthRepository();

  Future isSignedIn() {
    return _authRepository.isSignedIn();
  }

  Future isFirstTime(String userId) {
    return _authRepository.isFirstTime(userId);
  }

  Future storeUser(user) {
    return _authRepository.storeUser(user);
  }

  Future getUser() {
    return _authRepository.getUser();
  }

  Future logOut() {
    return _authRepository.logOut();
  }
}
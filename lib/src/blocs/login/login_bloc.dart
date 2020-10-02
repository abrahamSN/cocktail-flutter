import 'package:bloc/bloc.dart';

import './login_event.dart';
import './login_state.dart';

import '../../data/domain/domain.dart';

export './login_event.dart';
export './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserDomain _userDomain = UserDomain();
  final AuthDomain _authDomain = AuthDomain();

  LoginBloc() : super(null);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userDomain.signInWithGoogle();

      final user = await _authDomain.getUser();

      final isFirstTime = await _authDomain.isFirstTime(user.uid);

      if (!isFirstTime) {
        await _authDomain.storeUser(user);
      }

      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure();
    }
  }
}

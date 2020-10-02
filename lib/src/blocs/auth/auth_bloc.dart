import 'package:bloc/bloc.dart';
import 'package:cocktail_flutter/src/data/domain/auth_domain.dart';

import './auth_event.dart';
import './auth_state.dart';

export './auth_event.dart';
export './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDomain _authDomain = AuthDomain();

  AuthBloc() : super(UnInitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authDomain.isSignedIn();
      if (isSignedIn) {
        final user = await _authDomain.getUser();
        yield Authenticated(user);
      } else {
        yield UnAuthenticated();
      }
    } catch (_) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    yield Authenticated(await _authDomain.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    _authDomain.logOut();
    yield UnAuthenticated();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import './blocs/blocs.dart';
import './screens/home.dart';
import './screens/auth/login.dart';
import './screens/auth/welcome.dart';
import './screens/messages/chat.dart';
import './screens/messages/chat_global.dart';
import './screens/details/drink_details.dart';
import './screens/call_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handlePermission();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
        BlocProvider<ChatDetailBloc>(create: (context) => ChatDetailBloc()),
        BlocProvider<ChatGlobalBloc>(create: (context) => ChatGlobalBloc()),
        BlocProvider<ChatGlobalDetailBloc>(create: (context) => ChatGlobalDetailBloc()),
        BlocProvider<CocktailBloc>(create: (context) => CocktailBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<MessageBloc>(create: (context) => MessageBloc()),
        BlocProvider<NavbarBloc>(create: (context) => NavbarBloc()),
      ],
      child: MaterialApp(
        title: 'Cocktail Flutter',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            // context.bloc<AuthBloc>().add(AppStarted());
            return BlocBuilder<AuthBloc, AuthState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is UnInitialized) {
                  return Login();
                }
                if (state is Authenticated) {
                  return Home();
                }
                if (state is UnAuthenticated) {
                  return Login();
                }
                return Container();
              },
              // child: child,
            );
          },
          '/login': (context) => Login(),
          '/welcome': (context) => Welcome(),
          '/chat': (context) => Chat(),
          '/chat_global': (context) => ChatGlobal(),
          '/home': (context) => Home(),
          '/call_page': (context) => CallPage(),
          '/drink_detail': (context) => DrinkDetails(),
        },
      ),
    );
  }

  _handlePermission() async {
    await [Permission.camera, Permission.microphone].request();
  }
}

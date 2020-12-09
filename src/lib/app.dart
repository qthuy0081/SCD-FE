import 'package:flutter/material.dart';
import 'package:src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/config/theme.dart';
import 'package:src/views/splash/splash_page.dart';
import 'package:src/views/login/login_page.dart';
import 'package:src/views/home/home_page.dart';
import 'package:src/blocs/authentication/authentication_bloc.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const App({Key key, @required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository),
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  AppView({Key key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(), (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

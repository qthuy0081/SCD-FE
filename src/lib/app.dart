import 'package:flutter/material.dart';
import 'package:src/blocs/photos/photos_bloc.dart';
import 'package:src/models/models.dart';
import 'package:src/repositories/photos_firebase_repository.dart';
import 'package:src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/views/add_edit/add_edit.dart';
import 'package:src/views/splash/splash_page.dart';
import 'package:src/views/login/login_page.dart';
import 'package:src/views/home/home_page.dart';
import 'package:src/blocs/authentication/authentication_bloc.dart';
import 'blocs/app_tab/apptab_bloc.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final PhotoFirebaseRepository photoFirebaseRepository;
  const App(
      {Key key,
      @required this.authenticationRepository,
      @required this.photoFirebaseRepository})
      : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository),
            ),
            BlocProvider(
              create: (context) => AppTabBloc(),
            ),
            BlocProvider(
                create: (context) =>
                    PhotosBloc(photoRepository: photoFirebaseRepository)
                      ..add(LoadPhotos()))
          ],
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
      routes: {
        '/addPhoto': (context) {
          return AddEditScreen(
              onSave: (title, descript, userId, photoUrl, beConfidence, maConfidence) {
                BlocProvider.of<PhotosBloc>(context).add(AddPhoto(Photo(title,
                    descript: descript, userId: userId, photoUrl: photoUrl,benignRate: beConfidence, malignantRate: maConfidence)));
              },
              isEditing: false);
        }
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

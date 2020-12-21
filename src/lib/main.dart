import 'package:bloc/bloc.dart';
import 'package:src/blocs/bloc_observer.dart';
import 'package:src/repositories/photos_firebase_repository.dart';
import 'package:src/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  runApp(App(authenticationRepository: AuthenticationRepository(),photoFirebaseRepository: PhotoFirebaseRepository()));
}
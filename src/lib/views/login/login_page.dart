import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/cubits/login/login_cubit.dart';
import 'package:src/repositories/authentication_repo.dart';
import 'package:src/views/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: LoginForm(),
        ),
      ),
    );
  }
}

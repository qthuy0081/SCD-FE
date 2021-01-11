import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/cubits/signup/signup_cubit.dart';
import 'package:src/repositories/authentication_repo.dart';
import 'package:src/views/signup/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.orange[900],
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange[900],
            Colors.orange[800],
            Colors.orange[400]
          ])),
          child: BlocProvider(
            create: (context) =>
                SignUpCubit(context.read<AuthenticationRepository>()),
            child: SignUpForm(),
          ),
        ));
  }
}

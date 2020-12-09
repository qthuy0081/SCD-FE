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
        appBar: AppBar(title: const Text('Sign up')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (context) => SignUpCubit(context.read<AuthenticationRepository>()),
            child: SignUpForm(),
          ),
        ));
  }
}

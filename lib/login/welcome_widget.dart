import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/login/bloc/login_form_bloc.dart';
import 'package:sewoapp/login/bloc/login_form_event.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
                },
                child: const Text("Login"))),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
              onPressed: () {
                BlocProvider.of<LoginFormBloc>(context).add(ShowRegister());
              },
              child: const Text("Daftar")),
        ),
      ],
    );
  }
}

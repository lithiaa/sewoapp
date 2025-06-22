import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_tambah.dart';
import 'package:sewoapp/login/bloc/login_form_bloc.dart';
import 'package:sewoapp/login/bloc/login_form_event.dart';

class LoginRegisterWidget extends StatefulWidget {
  const LoginRegisterWidget({super.key});

  @override
  State<LoginRegisterWidget> createState() => _LoginRegisterWidgetState();
}

class _LoginRegisterWidgetState extends State<LoginRegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            BlocProvider.of<LoginFormBloc>(context).add(ShowRegister());
          },
          child: const Text(
            'Daftar',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

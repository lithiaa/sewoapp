import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_tambah.dart';
import 'package:sewoapp/home/home_screen.dart';
import 'package:sewoapp/login/bloc/login_bloc.dart';
import 'package:sewoapp/login/bloc/login_event.dart';
import 'package:sewoapp/login/bloc/login_state.dart';
import 'package:sewoapp/login/data/data_login.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  DataLogin data = DataLogin('', '', 'alumni');
  final List<String> genderItems = [
    'alumni',
    'admin',
    'guru/karyawan',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<LoginBloc>(context),
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: ((context, state) {
          return Card(

            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo_depan.png',
                      height: 150,
                    ),
                    // if (ConfigGlobal.register) const LoginRegisterWidget(),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),

                      child: SizedBox(
                        width: double.infinity,
                        // child: Text(
                        //   'Log In',
                        //   style: TextStyle(
                        //       fontSize: 20, fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.center,
                        // ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: double.infinity,
                    //   child: Text(
                    //     'Silahkan login',
                    //     textAlign: TextAlign.left,
                    //   ),
                    // ),
                    const SizedBox(height: 15),
                    TextFormField(
                      readOnly: state is LoginLoading,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        prefixIcon: const Icon(Icons.account_circle),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        hintText: 'Username',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username masih kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          data.username = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: state is LoginLoading,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        prefixIcon: const Icon(Icons.password),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password masih kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          data.password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: ConfigGlobal.lupaPassword
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        if (ConfigGlobal.lupaPassword)
                          TextButton(
                            onPressed: () {},
                            child: const Text('Lupa password?'),
                          ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(), 
                                backgroundColor: Style.buttonBackgroundColor,
                                foregroundColor: Colors.white, // Add white text color
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(LoginPost(data));
                                }
                              },
                              child: state is LoginLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Log In",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white), // Explicit white color
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (state is LoginError) const Text('Login Error'),
                    if (state is LoginGagal)
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text('Login Gagal ${state.data.pesan ?? ''}'),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                          "Don’t have an account? "),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(), 
                          backgroundColor: Style.buttonBackgroundColor,
                          foregroundColor: Colors.white, // Add white text color
                        ),
                        onPressed: () {
                          // BlocProvider.of<LoginFormBloc>(context)
                          //     .add(ShowRegister());
                          Navigator.of(context)
                              .pushNamed(DataPelangganTambahScreen.routeName,
                                  arguments: DataPelangganTambahArguments(
                                    data: DataPelanggan(),
                                    judul: "Sign Up",
                                  ));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white), // Explicit white color
                        ),
                      ),

                    )
                  ],

                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

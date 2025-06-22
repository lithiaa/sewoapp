import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_ubah_bloc.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';
import 'package:sewoapp/enum/enum_widget.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_bloc.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
import 'package:sewoapp/login/login_screen.dart';

class DataPelangganUbahScreen extends StatefulWidget {
  static const routeName = "data_pelanggan/edit";

  const DataPelangganUbahScreen({super.key});

  @override
  State<DataPelangganUbahScreen> createState() =>
      _DataPelangganUbahScreenState();
}

class _DataPelangganUbahScreenState extends State<DataPelangganUbahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataFilter filter = const DataFilter();

  DataPelanggan form = DataPelanggan();

  var idPelangganController = TextEditingController();
  var namaController = TextEditingController();
  var alamatController = TextEditingController();
  var noTeleponController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    idPelangganController.addListener(() {
      form.idPelanggan = idPelangganController.text;
    });

    namaController.addListener(() {
      form.nama = namaController.text;
    });

    alamatController.addListener(() {
      form.alamat = alamatController.text;
    });

    noTeleponController.addListener(() {
      form.noTelepon = noTeleponController.text;
    });

    emailController.addListener(() {
      form.email = emailController.text;
    });

    usernameController.addListener(() {
      form.username = usernameController.text;
    });

    passwordController.addListener(() {
      form.password = passwordController.text;
    });

    getSession();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as DataPelangganUbahArguments;


    idPelangganController.text = args.data.idPelanggan ?? "";
    namaController.text = args.data.nama ?? "";
    alamatController.text = args.data.alamat ?? "";
    noTeleponController.text = args.data.noTelepon ?? "";
    emailController.text = args.data.email ?? "";
    usernameController.text = args.data.username ?? "";
    passwordController.text = args.data.password ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFF11316C),
      appBar: AppBar(
        title: Text(args.judul),
        actions: [
          IconButton(
              onPressed: () async {
                await ConfigSessionManager.getInstance().logout();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.routeName,
                    (Route<dynamic> route) => false,
                  );
                }
              },
              icon: const Icon(Icons.power_settings_new)),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataPelangganUbahBloc, DataPelangganUbahState>(
            listener: (context, state) {
              if (state is DataPelangganUbahLoadSuccess) {
                const snackBar = SnackBar(
                  content: Text('Data berhasil diubah'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          ),
          BlocListener<DataPelangganBloc, DataPelangganState>(
            listener: (context, state) {
              if (state is DataPelangganLoadSuccess) {
                if (state.data.result.isNotEmpty) {
                  DataPelangganApiData data = state.data.result.first;

                  idPelangganController.text = data.idPelanggan!;
                  namaController.text = data.nama!;
                  alamatController.text = data.alamat!;
                  emailController.text = data.email!;
                  noTeleponController.text = data.noTelepon!;
                  usernameController.text = data.username!;
                }
              }
            },
          )
        ],
        child: SingleChildScrollView(
          child: Form(
            child: Card(

              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [

                    const SizedBox(height: 15),
                    // const LoginDataPelangganScreen(),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'My Profile',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,  // → merata tengah
                      ),
                    ),


                    Image.asset(
                  'assets/logo_profile.png',
                  height: 150,
                ),
                    const SizedBox(height: 15),

/*
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            border: OutlineInputBorder(),
                            labelText: 'Id Pelanggan',
                          ),
                          controller: idPelangganController,
                        ),
                        const SizedBox(height: 15),
*/

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nama',
                      ),
                      controller: namaController,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Alamat',
                      ),
                      controller: alamatController,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'No Telepon',
                      ),
                      controller: noTeleponController,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      controller: usernameController,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 15),

                    const SizedBox(height: 15),
                    Builder(
                      builder: (context) {
                        final statePelanggan =
                            BlocProvider.of<DataPelangganBloc>(context).state;
                        final stateUbahPelanggan =
                            BlocProvider.of<DataPelangganUbahBloc>(context)
                                .state;
                        return statePelanggan is DataPelangganLoading ||
                                stateUbahPelanggan is DataPelangganUbahLoading
                            ? const CircularProgressIndicator(
                                color: Style.buttonBackgroundColor,
                              )
                            : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(), backgroundColor: Style.buttonBackgroundColor,
                          ),
                                onPressed: () {
                                  BlocProvider.of<DataPelangganUbahBloc>(
                                    context,
                                  ).add(FetchDataPelangganUbah(form));
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.edit),
                                      SizedBox(width: 5),
                                      Text(
                                        "Save",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    idPelangganController.dispose();
    namaController.dispose();
    alamatController.dispose();
    noTeleponController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void getSession() async {
    LoginApiData? session = await ConfigSessionManager.getInstance().getData();
    if (session == null) {
      return;
    }
    filter = DataFilter(berdasarkan: "id_pelanggan", isi: "${session.id}");
    fetchData();
  }

  void fetchData() async {
    BlocProvider.of<DataPelangganBloc>(context).add(
      FetchDataPelanggan(filter),
    );
  }
}

class DataPelangganUbahArguments {
  final DataPelanggan data;
  final String judul;

  DataPelangganUbahArguments({
    required this.data,
    required this.judul,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_simpan_bloc.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/login/document_upload_page.dart';

class DataPelangganTambahScreen extends StatefulWidget {
  static const routeName = "data_pelanggan/tambah";

  const DataPelangganTambahScreen({super.key});

  @override
  State<DataPelangganTambahScreen> createState() =>
      _DataPelangganTambahScreenState();
}

class _DataPelangganTambahScreenState extends State<DataPelangganTambahScreen> {
  EnumRemote enumRemote = EnumRemote();

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
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as DataPelangganTambahArguments;

    /* tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? ""; */

    return BlocListener(
      bloc: BlocProvider.of<DataPelangganSimpanBloc>(context),
      listener: ((context, state) {
        if (state is DataPelangganSimpanLoadSuccess) {
          Navigator.of(context).pushReplacementNamed('/upload-document');
        }
      }),
      child: BlocBuilder<DataPelangganSimpanBloc, DataPelangganSimpanState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(args.judul)),
            body: SingleChildScrollView(
              child: Form(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      children: [
                        // const LoginDataPelangganScreen(),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Please complete the registration form',
                            textAlign: TextAlign.left,
                          ),
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
                        state is DataPelangganSimpanLoading
                            ? const CircularProgressIndicator(
                                color: Style.buttonBackgroundColor,
                              )
                            : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(), backgroundColor: Style.buttonBackgroundColor,
                          ),
                                onPressed: () {
                                  if (!isFormValid()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Harap lengkapi semua data terlebih dahuolu"),
                                      ),
                                    );
                                    return;
                                  }

                                  BlocProvider.of<DataPelangganSimpanBloc>(context)
                                      .add(FetchDataPelangganSimpan(form));
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.save),
                                      SizedBox(width: 5),
                                      Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),




                              ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text("Already have an account? "),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(), backgroundColor: Style.buttonBackgroundColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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

  bool isFormValid() {
    return namaController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        noTeleponController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}

class DataPelangganTambahArguments {
  final DataPelanggan data;
  final String judul;

  DataPelangganTambahArguments({
    required this.data,
    required this.judul,
  });
}

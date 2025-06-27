import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/enum_widget.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/login/bloc/login_form_bloc.dart';
import 'package:sewoapp/login/bloc/login_form_event.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/login/bloc/register_bloc.dart';
import 'package:sewoapp/login/bloc/register_event.dart';
import 'package:sewoapp/login/bloc/register_state.dart';
import 'package:sewoapp/login/data/data_register.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  EnumRemote enumRemote = EnumRemote();

  var agamaController = TextEditingController();
  var jenisKelaminController = TextEditingController();
  var statusPerkawinanController = TextEditingController();
  var tanggalLahirController = TextEditingController();

  DataRegister form = DataRegister();

  List<String> agama = [];
  List<String> jenisKelamin = [];
  List<String> statusPerkawinan = [];

  Future<void> fetchAgama() async {
    var data = await enumRemote.getData("data_peserta", "agama");
    agama = data.result;
  }

  Future<void> fetchJenisKelamin() async {
    var data = await enumRemote.getData("data_peserta", "jenis_kelamin");
    jenisKelamin = data.result;
  }

  Future<void> fetchStatusPerkawinan() async {
    var data = await enumRemote.getData("data_peserta", "status_perkawinan");
    statusPerkawinan = data.result;
  }

  @override
  void initState() {
    super.initState();

    fetchAgama();
    fetchJenisKelamin();
    fetchStatusPerkawinan();

    tanggalLahirController.addListener(() {
      form.tanggalLahir = tanggalLahirController.text;
    });

    agamaController.addListener(() {
      form.agama = agamaController.text;
    });

    jenisKelaminController.addListener(() {
      form.jenisKelamin = jenisKelaminController.text;
    });

    statusPerkawinanController.addListener(() {
      form.statusPerkawinan = statusPerkawinanController.text;
    });


  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<RegisterBloc>(context),
      listener: ((context, state) {
        if (state is RegisterSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          const snackBar = SnackBar(
            content: Text('Registrasi berhasil, silahkan login!'),
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    // const LoginRegisterWidget(),
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
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Nama Lengkap',
                      ),
                      onChanged: (value) => form.nama = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'NIK',
                      ),
                      onChanged: (value) => form.nik = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Tempat Lahir',
                      ),
                      onChanged: (value) => form.tempatLahir = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: tanggalLahirController,
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950, 1),
                          lastDate: DateTime(2025, 12),
                        ).then((pickedDate) {
                          if (pickedDate != null) {
                            tanggalLahirController.text =
                                DateFormat("y-M-d").format(pickedDate);
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Tanggal Lahir',
                      ),
                      onChanged: (value) => form.tanggalLahir = value,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pilih agama'),
                              content: EnumWidget(
                                items: agama,
                                onChange: (String value) {
                                  agamaController.text = value;
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        );
                      },
                      controller: agamaController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        border: OutlineInputBorder(),
                        labelText: 'Agama',
                      ),
                    ),

                    const SizedBox(height: 15),
                    TextFormField(
                      readOnly: true,
                      controller: jenisKelaminController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        border: OutlineInputBorder(),
                        labelText: 'Jenis Kelamin',
                      ),
                      onChanged: (String value) {
                        debugPrint("jenis kelamin $value");
                      },
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pilih jenis kelamin'),
                              content: EnumWidget(
                                items: jenisKelamin,
                                onChange: (String value) {
                                  jenisKelaminController.text = value;
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      readOnly: true,
                      controller: statusPerkawinanController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        border: OutlineInputBorder(),
                        labelText: 'Status Perkawinan',
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pilih status perkawinan'),
                              content: EnumWidget(
                                items: statusPerkawinan,
                                onChange: (String value) {
                                  statusPerkawinanController.text = value;
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.contacts),
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      onChanged: ((value) => form.username = value),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        onChanged: (String value) {
                          form.password = value;
                        }),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(), backgroundColor: Style.buttonBackgroundColor,
                        ),
                        onPressed: () {
                          BlocProvider.of<RegisterBloc>(context)
                              .add(RegisterPost(form));
                        },
                        child: state is RegisterLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Daftar"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text("Sudah memiliki akun"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(), backgroundColor: Style.buttonBackgroundColor,
                        ),
                        onPressed: () {
                          BlocProvider.of<LoginFormBloc>(context)
                              .add(ShowLogin());
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

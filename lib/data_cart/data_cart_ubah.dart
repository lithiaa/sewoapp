import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/enum/enum_widget.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_bloc.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';

class DataCartUbahScreen extends StatefulWidget {
  static const routeName = "data_cart/edit";
  const DataCartUbahScreen({super.key});

  @override
  State<DataCartUbahScreen> createState() => _DataCartUbahScreenState();
}

class _DataCartUbahScreenState extends State<DataCartUbahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataCart form = DataCart();

  var idPemesananController = TextEditingController();
  var tanggalPemesananController = TextEditingController();
  var idPelangganController = TextEditingController();
  var idOngkirController = TextEditingController();
  var idBankController = TextEditingController();
  var tanggalUploadBuktiPembayaranController = TextEditingController();
  var uploadBuktiPembayaranController = TextEditingController();
  var statusController = TextEditingController();
  List<String> status = [];

  Future<void> fetchStatus() async {
    var data = await enumRemote.getData('data_cart', 'status');
    status = data.result;
  }

  @override
  void initState() {
    super.initState();

    idPemesananController.addListener(() {
      form.idPemesanan = idPemesananController.text;
    });

    tanggalPemesananController.addListener(() {
      form.tanggalPemesanan = tanggalPemesananController.text;
    });

    idPelangganController.addListener(() {
      form.idPelanggan = idPelangganController.text;
    });

    idOngkirController.addListener(() {
      form.idOngkir = idOngkirController.text;
    });

    idBankController.addListener(() {
      form.idBank = idBankController.text;
    });

    tanggalUploadBuktiPembayaranController.addListener(() {
      form.tanggalUploadBuktiPembayaran =
          tanggalUploadBuktiPembayaranController.text;
    });

    uploadBuktiPembayaranController.addListener(() {
      form.uploadBuktiPembayaran = uploadBuktiPembayaranController.text;
    });

    statusController.addListener(() {
      form.status = statusController.text;
    });

    fetchStatus();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as DataCartUbahArguments;

    /*
    idProgramHafalanController.text = args.data.idProgramHafalan ?? "";
    tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? "";
    */

    idPemesananController.text = args.data.idPemesanan ?? "";
    tanggalPemesananController.text = args.data.tanggalPemesanan ?? "";
    idPelangganController.text = args.data.idPelanggan ?? "";
    idOngkirController.text = args.data.idOngkir ?? "";
    idBankController.text = args.data.idBank ?? "";
    tanggalUploadBuktiPembayaranController.text =
        args.data.tanggalUploadBuktiPembayaran ?? "";
    uploadBuktiPembayaranController.text =
        args.data.uploadBuktiPembayaran ?? "";
    statusController.text = args.data.status ?? "";

    return BlocListener(
      bloc: BlocProvider.of<DataCartBloc>(context),
      listener: ((context, state) {
        //if (state is DataCartSuccess) {
        // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
        //const snackBar = SnackBar(
        //content: Text('Registrasi berhasil, silahkan login!'),
        //);
        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataCartBloc, DataCartState>(
        builder: (context, state) {
          return SingleChildScrollView(
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
                      // const LoginDataCartScreen(),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 5),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Selamat datang',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Silahkan lengkapi form pendaftaran',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Id Pemesanan',
                        ),
                        controller: idPemesananController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        controller: tanggalPemesananController,
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990, 1),
                            lastDate: DateTime(2025, 12),
                          ).then((pickedDate) {
                            if (pickedDate != null) {
                              tanggalPemesananController.text =
                                  DateFormat('y-M-d').format(pickedDate);
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Tanggal Pemesanan',
                        ),
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Id Pelanggan',
                        ),
                        controller: idPelangganController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Id Ongkir',
                        ),
                        controller: idOngkirController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Id Bank',
                        ),
                        controller: idBankController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Tanggal Upload Bukti Pembayaran',
                        ),
                        controller: tanggalUploadBuktiPembayaranController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          labelText: 'Upload Bukti Pembayaran',
                        ),
                        controller: uploadBuktiPembayaranController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pilih Status'),
                                content: EnumWidget(
                                  items: status,
                                  onChange: (String value) {
                                    statusController.text = value;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        controller: statusController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          border: OutlineInputBorder(),
                          labelText: 'Status',
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
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
    idPemesananController.dispose();
    tanggalPemesananController.dispose();
    idPelangganController.dispose();
    idOngkirController.dispose();
    idBankController.dispose();
    tanggalUploadBuktiPembayaranController.dispose();
    uploadBuktiPembayaranController.dispose();
    statusController.dispose();

    super.dispose();
  }
}

class DataCartUbahArguments {
  final DataCart data;
  final String judul;

  DataCartUbahArguments({
    required this.data,
    required this.judul,
  });
}

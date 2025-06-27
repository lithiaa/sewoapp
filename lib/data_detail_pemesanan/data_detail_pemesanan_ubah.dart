import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_detail_pemesanan/bloc/data_detail_pemesanan_bloc.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan.dart';

class DataDetailPemesananUbahScreen extends StatefulWidget {
  static const routeName = "data_detail_pemesanan/edit";
  const DataDetailPemesananUbahScreen({super.key});

  @override
  State<DataDetailPemesananUbahScreen> createState() => _DataDetailPemesananUbahScreenState();
}

class _DataDetailPemesananUbahScreenState extends State<DataDetailPemesananUbahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataDetailPemesanan form = DataDetailPemesanan();
    
  var idDetailPemesananController = TextEditingController();
var idPemesananController = TextEditingController();
var idProdukController = TextEditingController();
var jumlahController = TextEditingController();
var hargaController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idDetailPemesananController.addListener(() {
        form.idDetailPemesanan = idDetailPemesananController.text;
        });
        
idPemesananController.addListener(() {
        form.idPemesanan = idPemesananController.text;
        });
        
idProdukController.addListener(() {
        form.idProduk = idProdukController.text;
        });
        
jumlahController.addListener(() {
        form.jumlah = jumlahController.text;
        });
        
hargaController.addListener(() {
        form.harga = hargaController.text;
        });
        


  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as DataDetailPemesananUbahArguments;

    /*
    idProgramHafalanController.text = args.data.idProgramHafalan ?? "";
    tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? "";
    */

    idDetailPemesananController.text = args.data.idDetailPemesanan ?? "";
    idPemesananController.text = args.data.idPemesanan ?? "";
    idProdukController.text = args.data.idProduk ?? "";
    jumlahController.text = args.data.jumlah ?? "";
    hargaController.text = args.data.harga ?? "";


    return BlocListener(
      bloc: BlocProvider.of<DataDetailPemesananBloc>(context),
      listener: ((context, state) {
        //if (state is DataDetailPemesananSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          //const snackBar = SnackBar(
            //content: Text('Registrasi berhasil, silahkan login!'),
          //);
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataDetailPemesananBloc, DataDetailPemesananState>(
        builder: (context, state) {
          return SingleChildScrollView(
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
                        // const LoginDataDetailPemesananScreen(),
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
                        labelText: 'Id Detail Pemesanan',
                      ),
                      controller: idDetailPemesananController,
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Produk',
                      ),
                      controller: idProdukController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Jumlah',
                      ),
                      controller: jumlahController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Harga',
                      ),
                      controller: hargaController,
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
    idDetailPemesananController.dispose();
idPemesananController.dispose();
idProdukController.dispose();
jumlahController.dispose();
hargaController.dispose();

    super.dispose();
  }

}


class DataDetailPemesananUbahArguments {
  final DataDetailPemesanan data;
  final String judul;

  DataDetailPemesananUbahArguments({
    required this.data,
    required this.judul,
  });
}

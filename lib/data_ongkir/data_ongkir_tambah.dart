import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_simpan_bloc.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir.dart';

class DataOngkirTambahScreen extends StatefulWidget {
  static const routeName = "data_ongkir/tambah";
  const DataOngkirTambahScreen({super.key});

  @override
  State<DataOngkirTambahScreen> createState() => _DataOngkirTambahScreenState();
}

class _DataOngkirTambahScreenState extends State<DataOngkirTambahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataOngkir form = DataOngkir();
    
  var idKurirController = TextEditingController();
var kurirController = TextEditingController();
var tujuanController = TextEditingController();
var biayaController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idKurirController.addListener(() {
        form.idKurir = idKurirController.text;
        });
        
kurirController.addListener(() {
        form.kurir = kurirController.text;
        });
        
tujuanController.addListener(() {
        form.tujuan = tujuanController.text;
        });
        
biayaController.addListener(() {
        form.biaya = biayaController.text;
        });
        


  }

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments
        as DataOngkirTambahArguments;

    /* tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? ""; */

    return BlocListener(
      bloc: BlocProvider.of<DataOngkirSimpanBloc>(context),
      listener: ((context, state) {
        //if (state is DataOngkirSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          //const snackBar = SnackBar(
            //content: Text('Registrasi berhasil, silahkan login!'),
          //);
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataOngkirSimpanBloc, DataOngkirSimpanState>(
        builder: (context, state) {
          return 
             Scaffold(
          appBar: AppBar(title: Text(args.judul)),
          body:  SingleChildScrollView(
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
                            // const LoginDataOngkirScreen(),
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
                        labelText: 'Id Kurir',
                      ),
                      controller: idKurirController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Kurir',
                      ),
                      controller: kurirController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Tujuan',
                      ),
                      controller: tujuanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Biaya',
                      ),
                      controller: biayaController,
                    ),
                    const SizedBox(height: 15),
        


                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Style.buttonBackgroundColor,
                        ),
                        onPressed: () {
                          BlocProvider.of<DataOngkirSimpanBloc>(context)
                              .add(FetchDataOngkirSimpan(form));
                        },
                        child: state is DataOngkirSimpanLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.save),
                                  SizedBox(width: 5),
                                  Text(
                                    "Simpan",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      )
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
    idKurirController.dispose();
kurirController.dispose();
tujuanController.dispose();
biayaController.dispose();

    super.dispose();
  }

}


class DataOngkirTambahArguments {
  final DataOngkir data;
  final String judul;

  DataOngkirTambahArguments({
    required this.data,
    required this.judul,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/enum_widget.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_satuan/bloc/data_satuan_simpan_bloc.dart';
import 'package:sewoapp/data_satuan/data/data_satuan.dart';

class DataSatuanTambahScreen extends StatefulWidget {
  static const routeName = "data_satuan/tambah";
  const DataSatuanTambahScreen({super.key});

  @override
  State<DataSatuanTambahScreen> createState() => _DataSatuanTambahScreenState();
}

class _DataSatuanTambahScreenState extends State<DataSatuanTambahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataSatuan form = DataSatuan();
    
  var idSatuanController = TextEditingController();
var satuanController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idSatuanController.addListener(() {
        form.idSatuan = idSatuanController.text;
        });
        
satuanController.addListener(() {
        form.satuan = satuanController.text;
        });
        


  }

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments
        as DataSatuanTambahArguments;

    /* tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? ""; */

    return BlocListener(
      bloc: BlocProvider.of<DataSatuanSimpanBloc>(context),
      listener: ((context, state) {
        //if (state is DataSatuanSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          //const snackBar = SnackBar(
            //content: Text('Registrasi berhasil, silahkan login!'),
          //);
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataSatuanSimpanBloc, DataSatuanSimpanState>(
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
                            // const LoginDataSatuanScreen(),
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
                        labelText: 'Id Satuan',
                      ),
                      controller: idSatuanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Satuan',
                      ),
                      controller: satuanController,
                    ),
                    const SizedBox(height: 15),
        


                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Style.buttonBackgroundColor,
                        ),
                        onPressed: () {
                          BlocProvider.of<DataSatuanSimpanBloc>(context)
                              .add(FetchDataSatuanSimpan(form));
                        },
                        child: state is DataSatuanSimpanLoading
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
    idSatuanController.dispose();
satuanController.dispose();

    super.dispose();
  }

}


class DataSatuanTambahArguments {
  final DataSatuan data;
  final String judul;

  DataSatuanTambahArguments({
    required this.data,
    required this.judul,
  });
}

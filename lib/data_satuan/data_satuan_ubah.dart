import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_satuan/bloc/data_satuan_bloc.dart';
import 'package:sewoapp/data_satuan/data/data_satuan.dart';

class DataSatuanUbahScreen extends StatefulWidget {
  static const routeName = "data_satuan/edit";
  const DataSatuanUbahScreen({super.key});

  @override
  State<DataSatuanUbahScreen> createState() => _DataSatuanUbahScreenState();
}

class _DataSatuanUbahScreenState extends State<DataSatuanUbahScreen> {
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
        as DataSatuanUbahArguments;

    /*
    idProgramHafalanController.text = args.data.idProgramHafalan ?? "";
    tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? "";
    */

    idSatuanController.text = args.data.idSatuan ?? "";
    satuanController.text = args.data.satuan ?? "";


    return BlocListener(
      bloc: BlocProvider.of<DataSatuanBloc>(context),
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
      child: BlocBuilder<DataSatuanBloc, DataSatuanState>(
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
    idSatuanController.dispose();
satuanController.dispose();

    super.dispose();
  }

}


class DataSatuanUbahArguments {
  final DataSatuan data;
  final String judul;

  DataSatuanUbahArguments({
    required this.data,
    required this.judul,
  });
}

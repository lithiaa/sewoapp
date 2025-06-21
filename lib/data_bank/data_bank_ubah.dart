import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/enum_widget.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_bank/bloc/data_bank_bloc.dart';
import 'package:sewoapp/data_bank/data/data_bank.dart';

class DataBankUbahScreen extends StatefulWidget {
  static const routeName = "data_bank/edit";
  const DataBankUbahScreen({super.key});

  @override
  State<DataBankUbahScreen> createState() => _DataBankUbahScreenState();
}

class _DataBankUbahScreenState extends State<DataBankUbahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataBank form = DataBank();
    
  var idBankController = TextEditingController();
var namaBankController = TextEditingController();
var namaPemilikController = TextEditingController();
var rekeningController = TextEditingController();
var fotoLogoBankController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idBankController.addListener(() {
        form.idBank = idBankController.text;
        });
        
namaBankController.addListener(() {
        form.namaBank = namaBankController.text;
        });
        
namaPemilikController.addListener(() {
        form.namaPemilik = namaPemilikController.text;
        });
        
rekeningController.addListener(() {
        form.rekening = rekeningController.text;
        });
        
fotoLogoBankController.addListener(() {
        form.fotoLogoBank = fotoLogoBankController.text;
        });
        


  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as DataBankUbahArguments;

    /*
    idProgramHafalanController.text = args.data.idProgramHafalan ?? "";
    tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? "";
    */

    idBankController.text = args.data.idBank ?? "";
    namaBankController.text = args.data.namaBank ?? "";
    namaPemilikController.text = args.data.namaPemilik ?? "";
    rekeningController.text = args.data.rekening ?? "";
    fotoLogoBankController.text = args.data.fotoLogoBank ?? "";


    return BlocListener(
      bloc: BlocProvider.of<DataBankBloc>(context),
      listener: ((context, state) {
        //if (state is DataBankSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          //const snackBar = SnackBar(
            //content: Text('Registrasi berhasil, silahkan login!'),
          //);
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataBankBloc, DataBankState>(
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
                        // const LoginDataBankScreen(),
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
                        labelText: 'Id Bank',
                      ),
                      controller: idBankController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nama Bank',
                      ),
                      controller: namaBankController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nama Pemilik',
                      ),
                      controller: namaPemilikController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Rekening',
                      ),
                      controller: rekeningController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Foto Logo Bank',
                      ),
                      controller: fotoLogoBankController,
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
    idBankController.dispose();
namaBankController.dispose();
namaPemilikController.dispose();
rekeningController.dispose();
fotoLogoBankController.dispose();

    super.dispose();
  }

}


class DataBankUbahArguments {
  final DataBank data;
  final String judul;

  DataBankUbahArguments({
    required this.data,
    required this.judul,
  });
}

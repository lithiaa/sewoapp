import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_kategori/bloc/data_kategori_simpan_bloc.dart';
import 'package:sewoapp/data_kategori/data/data_kategori.dart';

class DataKategoriTambahScreen extends StatefulWidget {
  static const routeName = "data_kategori/tambah";
  const DataKategoriTambahScreen({super.key});

  @override
  State<DataKategoriTambahScreen> createState() => _DataKategoriTambahScreenState();
}

class _DataKategoriTambahScreenState extends State<DataKategoriTambahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataKategori form = DataKategori();
    
  var idKategoriController = TextEditingController();
var kategoriController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idKategoriController.addListener(() {
        form.idKategori = idKategoriController.text;
        });
        
kategoriController.addListener(() {
        form.kategori = kategoriController.text;
        });
        


  }

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments
        as DataKategoriTambahArguments;

    /* tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? ""; */

    return BlocListener(
      bloc: BlocProvider.of<DataKategoriSimpanBloc>(context),
      listener: ((context, state) {
        //if (state is DataKategoriSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          //const snackBar = SnackBar(
            //content: Text('Registrasi berhasil, silahkan login!'),
          //);
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataKategoriSimpanBloc, DataKategoriSimpanState>(
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
                            // const LoginDataKategoriScreen(),
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
                        labelText: 'Id Kategori',
                      ),
                      controller: idKategoriController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Kategori',
                      ),
                      controller: kategoriController,
                    ),
                    const SizedBox(height: 15),
        


                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Style.buttonBackgroundColor,
                        ),
                        onPressed: () {
                          BlocProvider.of<DataKategoriSimpanBloc>(context)
                              .add(FetchDataKategoriSimpan(form));
                        },
                        child: state is DataKategoriSimpanLoading
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
    idKategoriController.dispose();
kategoriController.dispose();

    super.dispose();
  }

}


class DataKategoriTambahArguments {
  final DataKategori data;
  final String judul;

  DataKategoriTambahArguments({
    required this.data,
    required this.judul,
  });
}

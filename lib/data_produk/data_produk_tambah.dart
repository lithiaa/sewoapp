import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_produk/bloc/data_produk_simpan_bloc.dart';
import 'package:sewoapp/data_produk/data/data_produk.dart';

class DataProdukTambahScreen extends StatefulWidget {
  static const routeName = "data_produk/tambah";
  const DataProdukTambahScreen({super.key});

  @override
  State<DataProdukTambahScreen> createState() => _DataProdukTambahScreenState();
}

class _DataProdukTambahScreenState extends State<DataProdukTambahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataProduk form = DataProduk();
    
  var idProdukController = TextEditingController();
var namaProdukController = TextEditingController();
var idKategoriController = TextEditingController();
var hargaController = TextEditingController();
var jumlahController = TextEditingController();
var deskripsiController = TextEditingController();


  @override
  void initState() {
    super.initState();

    idProdukController.addListener(() {
        form.idProduk = idProdukController.text;
        });
        
namaProdukController.addListener(() {
        form.namaProduk = namaProdukController.text;
        });
        
idKategoriController.addListener(() {
        form.idKategori = idKategoriController.text;
        });
        
hargaController.addListener(() {
        form.harga = hargaController.text;
        });
        
jumlahController.addListener(() {
        form.jumlah = jumlahController.text;
        });
        
deskripsiController.addListener(() {
        form.deskripsi = deskripsiController.text;
        });
        


  }

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments
        as DataProdukTambahArguments;

    /* tanggalController.text = args.data.tanggal ?? "";
    hapalanController.text = args.data.hapalan ?? "";
    keteranganController.text = args.data.keterangan ?? ""; */

    return BlocListener(
      bloc: BlocProvider.of<DataProdukSimpanBloc>(context),
      listener: ((context, state) {
        //if (state is DataProdukSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          //const snackBar = SnackBar(
            //content: Text('Registrasi berhasil, silahkan login!'),
          //);
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataProdukSimpanBloc, DataProdukSimpanState>(
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
                            // const LoginDataProdukScreen(),
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
                        labelText: 'Id Produk',
                      ),
                      controller: idProdukController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nama Produk',
                      ),
                      controller: namaProdukController,
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
                        labelText: 'Harga',
                      ),
                      controller: hargaController,
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
                        labelText: 'Deskripsi',
                      ),
                      controller: deskripsiController,
                    ),
                    const SizedBox(height: 15),
        


                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Style.buttonBackgroundColor,
                        ),
                        onPressed: () {
                          BlocProvider.of<DataProdukSimpanBloc>(context)
                              .add(FetchDataProdukSimpan(form));
                        },
                        child: state is DataProdukSimpanLoading
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
    idProdukController.dispose();
namaProdukController.dispose();
idKategoriController.dispose();
hargaController.dispose();
jumlahController.dispose();
deskripsiController.dispose();

    super.dispose();
  }

}


class DataProdukTambahArguments {
  final DataProduk data;
  final String judul;

  DataProdukTambahArguments({
    required this.data,
    required this.judul,
  });
}

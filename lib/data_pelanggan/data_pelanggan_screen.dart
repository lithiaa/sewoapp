import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_bloc.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_hapus_bloc.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_simpan_bloc.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_ubah_bloc.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_tambah.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_tampil.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_ubah.dart';
import 'package:sewoapp/widgets/loading_widget.dart';
import 'package:sewoapp/widgets/tombol.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'data/data_pelanggan.dart';

class DataPelangganScreen extends StatefulWidget {
  static const routeName = '/data_pelanggan';

  const DataPelangganScreen ({super.key});

  @override
  State<DataPelangganScreen> createState() => _DataPelangganScreenState();
}

class _DataPelangganScreenState extends State<DataPelangganScreen> {
  DataFilter filter = const DataFilter();
  List<String> listPencarian = ["Hello", "Ayam"];
  String valuePencarian = "Hello";

  var pencarianController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Pelanggan',
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataPelangganHapusBloc,
              DataPelangganHapusState>(
            listener: (context, state) {
              if (state is DataPelangganHapusLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataPelangganUbahBloc, DataPelangganUbahState>(
            listener: (context, state) {
              if (state is DataPelangganUbahLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataPelangganSimpanBloc, DataPelangganSimpanState>(
            listener: (context, state) {
              if (state is DataPelangganSimpanLoadSuccess) {
                fetchData();
              }
            },
          ),
        ],
        child: Stack(
          children: [
            ListView(
              children: [
                Image.asset(
                  "assets/background_data.png",
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 10,
              child: Image.asset(
                "assets/avatar.png",
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: const Text(
                        "Silahkan Input Data Pelanggan",
                        style: TextStyle(fontSize: 18),
                      ),
                    ), */
                      Row(
                        children: [
                          TombolTambahWidget(
                            onPress: () {
                              Navigator.pushNamed(
                                context,
                                DataPelangganTambahScreen.routeName,
                                arguments: DataPelangganTambahArguments(
                                  data: DataPelanggan(),
                                  judul: "Tambah Data Pelanggan",
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          TombolRefreshWidget(
                            onPress: () {
                              fetchData();
                            },
                          ),
                          const SizedBox(width: 10),
                          TombolCariWidget(
                            onPress: () {
                              _showPencarianDialog();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        final stateData =
                            context.watch<DataPelangganBloc>().state;
                        final stateHapus =
                            context.watch<DataPelangganHapusBloc>().state;
                        if (stateData is DataPelangganLoading ||
                            stateHapus is DataPelangganHapusLoading) {
                          return const LoadingWidget();
                        }
                        if (stateData is DataPelangganLoadSuccess) {
                          List<DataPelangganApiData> data =
                              stateData.data.result;
                          if (data.isEmpty) {
                            return NoInternetWidget(
                              pesan: "Maaf, data masih kosong!",
                            );
                          }
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: ((context, index) {
                              return DataPelangganTampil(
                                data: data[index],
                                onTapHapus: (value) async {
                                  BlocProvider.of<DataPelangganHapusBloc>(
                                    context,
                                  ).add(
                                    FetchDataPelangganHapus(
                                      data: value,
                                    ),
                                  );
                                },
                                onTapEdit: (value) async {
                                  var data = DataPelanggan(
									idPelanggan : value.idPelanggan,
									nama : value.nama,
									alamat : value.alamat,
									noTelepon : value.noTelepon,
									email : value.email,
									username : value.username,
									password : value.password,
                                  );
                                  await Navigator.of(context).pushNamed(
                                    DataPelangganUbahScreen.routeName,
                                    arguments: DataPelangganUbahArguments(
                                      data: data,
                                      judul: "Edit Data Pelanggan",
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        }
                        if (stateData is DataPelangganLoadFailure) {
                          return NoInternetWidget(pesan: stateData.pesan);
                        }
                        return NoInternetWidget();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPencarianDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Pencarian'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  DropdownButtonFormField<String>(
                    value: valuePencarian,
                    decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      filled: true,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        valuePencarian = value!;
                      });
                    },
                    items: listPencarian
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: pencarianController,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Cari disini',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Cari'),
                        onPressed: () {
                          filter = DataFilter(
                            idPeserta: filter.idPeserta,
                            berdasarkan: filter.berdasarkan,
                            isi: filter.isi,
                          );
                          fetchData();

                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void getSession() async {
    var session = await ConfigSessionManager.getInstance().getData();
    if (session == null) {
      return;
    }
    filter = DataFilter(berdasarkan: "id_pelanggan", isi: "${session.id}");
    fetchData();
  }

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  void fetchData() async {
    BlocProvider.of<DataPelangganBloc>(context).add(
      FetchDataPelanggan(filter),
    );
  }
}


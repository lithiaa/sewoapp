import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_bloc.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_hapus_bloc.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_simpan_bloc.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_ubah_bloc.dart';
import 'package:sewoapp/data_pemesanan/data/data_pemesanan_apidata.dart';
import 'package:sewoapp/data_pemesanan/data_pemesanan_tampil.dart';
import 'package:sewoapp/data_pemesanan/data_pemesanan_ubah.dart';
import 'package:sewoapp/widgets/loading_widget.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'data/data_pemesanan.dart';


class DataPemesananScreen extends StatefulWidget {
  static const routeName = '/data_pemesanan';

  const DataPemesananScreen({super.key});

  @override
  State<DataPemesananScreen> createState() => _DataPemesananScreenState();
}

class _DataPemesananScreenState extends State<DataPemesananScreen> {
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
      backgroundColor: const Color(0xFF11316C),
      appBar: AppBar(
        title: const Text(
          'History',
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataPemesananHapusBloc, DataPemesananHapusState>(
            listener: (context, state) {
              if (state is DataPemesananHapusLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataPemesananUbahBloc, DataPemesananUbahState>(
            listener: (context, state) {
              if (state is DataPemesananUbahLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataPemesananSimpanBloc, DataPemesananSimpanState>(
            listener: (context, state) {
              if (state is DataPemesananSimpanLoadSuccess) {
                fetchData();
              }
            },
          ),
        ],
        child: Stack(
          children: [
            ListView(
              // children: [
              //   Image.asset(
              //     "assets/background_data.png",
              //     fit: BoxFit.fitWidth,
              //   ),
              // ],
            ),
            // Positioned(
            //   right: 0,
            //   top: 10,
            //   child: Image.asset(
            //     "assets/avatar.png",
            //     height: 100,
            //   ),
            // ),
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
                        "Silahkan Input Data Pemesanan",
                        style: TextStyle(fontSize: 18),
                      ),
                    ), */
                      /* Row(
                        children: [
                          TombolTambahWidget(
                            onPress: () {
                              Navigator.pushNamed(
                                context,
                                DataPemesananTambahScreen.routeName,
                                arguments: DataPemesananTambahArguments(
                                  data: DataPemesanan(),
                                  judul: "Tambah Data Pemesanan",
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
                      ), */
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        final stateData =
                            context.watch<DataPemesananBloc>().state;
                        final stateHapus =
                            context.watch<DataPemesananHapusBloc>().state;
                        if (stateData is DataPemesananLoading ||
                            stateHapus is DataPemesananHapusLoading) {
                          return const LoadingWidget();
                        }
                        if (stateData is DataPemesananLoadSuccess) {
                          List<DataPemesananApiData> data =
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
                              return DataPemesananTampil(
                                data: data[index],
                                onTapHapus: (value) async {
                                  BlocProvider.of<DataPemesananHapusBloc>(
                                    context,
                                  ).add(
                                    FetchDataPemesananHapus(
                                      data: value,
                                    ),
                                  );
                                },
                                onTapEdit: (value) async {
                                  var data = DataPemesanan(
                                    idPemesanan: value.idPemesanan,
                                    tanggalPemesanan: value.tanggalPemesanan,
                                    idPelanggan: value.idPelanggan,
                                    idOngkir: value.idOngkir,
                                    idBank: value.idBank,
                                    tanggalUploadBuktiPembayaran:
                                        value.tanggalUploadBuktiPembayaran,
                                    uploadBuktiPembayaran:
                                        value.uploadBuktiPembayaran,
                                    status: value.status,
                                  );
                                  await Navigator.of(context).pushNamed(
                                    DataPemesananUbahScreen.routeName,
                                    arguments: DataPemesananUbahArguments(
                                      data: data,
                                      judul: "Edit Data Pemesanan",
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        }
                        if (stateData is DataPemesananLoadFailure) {
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
    BlocProvider.of<DataPemesananBloc>(context).add(
      FetchDataPemesanan(filter),
    );
  }
}

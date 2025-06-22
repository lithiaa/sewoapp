import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_satuan/bloc/data_satuan_bloc.dart';
import 'package:sewoapp/data_satuan/bloc/data_satuan_hapus_bloc.dart';
import 'package:sewoapp/data_satuan/bloc/data_satuan_simpan_bloc.dart';
import 'package:sewoapp/data_satuan/bloc/data_satuan_ubah_bloc.dart';
import 'package:sewoapp/data_satuan/data/data_satuan_apidata.dart';
import 'package:sewoapp/data_satuan/data_satuan_tambah.dart';
import 'package:sewoapp/data_satuan/data_satuan_tampil.dart';
import 'package:sewoapp/data_satuan/data_satuan_ubah.dart';
import 'package:sewoapp/widgets/loading_widget.dart';
import 'package:sewoapp/widgets/tombol.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'data/data_satuan.dart';

class DataSatuanScreen extends StatefulWidget {
  static const routeName = '/data_satuan';

  const DataSatuanScreen ({super.key});

  @override
  State<DataSatuanScreen> createState() => _DataSatuanScreenState();
}

class _DataSatuanScreenState extends State<DataSatuanScreen> {
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
          'Data Satuan',
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataSatuanHapusBloc,
              DataSatuanHapusState>(
            listener: (context, state) {
              if (state is DataSatuanHapusLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataSatuanUbahBloc, DataSatuanUbahState>(
            listener: (context, state) {
              if (state is DataSatuanUbahLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataSatuanSimpanBloc, DataSatuanSimpanState>(
            listener: (context, state) {
              if (state is DataSatuanSimpanLoadSuccess) {
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
                        "Silahkan Input Data Satuan",
                        style: TextStyle(fontSize: 18),
                      ),
                    ), */
                      Row(
                        children: [
                          TombolTambahWidget(
                            onPress: () {
                              Navigator.pushNamed(
                                context,
                                DataSatuanTambahScreen.routeName,
                                arguments: DataSatuanTambahArguments(
                                  data: DataSatuan(),
                                  judul: "Tambah Data Satuan",
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
                            context.watch<DataSatuanBloc>().state;
                        final stateHapus =
                            context.watch<DataSatuanHapusBloc>().state;
                        if (stateData is DataSatuanLoading ||
                            stateHapus is DataSatuanHapusLoading) {
                          return const LoadingWidget();
                        }
                        if (stateData is DataSatuanLoadSuccess) {
                          List<DataSatuanApiData> data =
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
                              return DataSatuanTampil(
                                data: data[index],
                                onTapHapus: (value) async {
                                  BlocProvider.of<DataSatuanHapusBloc>(
                                    context,
                                  ).add(
                                    FetchDataSatuanHapus(
                                      data: value,
                                    ),
                                  );
                                },
                                onTapEdit: (value) async {
                                  var data = DataSatuan(
									idSatuan : value.idSatuan,
									satuan : value.satuan,
                                  );
                                  await Navigator.of(context).pushNamed(
                                    DataSatuanUbahScreen.routeName,
                                    arguments: DataSatuanUbahArguments(
                                      data: data,
                                      judul: "Edit Data Satuan",
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        }
                        if (stateData is DataSatuanLoadFailure) {
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
    filter = DataFilter(idPeserta: "${session.id}");
    fetchData();
  }

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  void fetchData() async {
    BlocProvider.of<DataSatuanBloc>(context).add(
      FetchDataSatuan(filter),
    );
  }
}


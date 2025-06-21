import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_admin/bloc/data_admin_bloc.dart';
import 'package:sewoapp/data_admin/bloc/data_admin_hapus_bloc.dart';
import 'package:sewoapp/data_admin/bloc/data_admin_simpan_bloc.dart';
import 'package:sewoapp/data_admin/bloc/data_admin_ubah_bloc.dart';
import 'package:sewoapp/data_admin/data/data_admin_apidata.dart';
import 'package:sewoapp/data_admin/data_admin_tambah.dart';
import 'package:sewoapp/data_admin/data_admin_tampil.dart';
import 'package:sewoapp/data_admin/data_admin_ubah.dart';
import 'package:sewoapp/widgets/loading_widget.dart';
import 'package:sewoapp/widgets/tombol.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'data/data_admin.dart';

class DataAdminScreen extends StatefulWidget {
  static const routeName = '/data_admin';

  const DataAdminScreen ({super.key});

  @override
  State<DataAdminScreen> createState() => _DataAdminScreenState();
}

class _DataAdminScreenState extends State<DataAdminScreen> {
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
          'Data Admin',
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DataAdminHapusBloc,
              DataAdminHapusState>(
            listener: (context, state) {
              if (state is DataAdminHapusLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataAdminUbahBloc, DataAdminUbahState>(
            listener: (context, state) {
              if (state is DataAdminUbahLoadSuccess) {
                fetchData();
              }
            },
          ),
          BlocListener<DataAdminSimpanBloc, DataAdminSimpanState>(
            listener: (context, state) {
              if (state is DataAdminSimpanLoadSuccess) {
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
                        "Silahkan Input Data Admin",
                        style: TextStyle(fontSize: 18),
                      ),
                    ), */
                      Row(
                        children: [
                          TombolTambahWidget(
                            onPress: () {
                              Navigator.pushNamed(
                                context,
                                DataAdminTambahScreen.routeName,
                                arguments: DataAdminTambahArguments(
                                  data: DataAdmin(),
                                  judul: "Tambah Data Admin",
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
                            context.watch<DataAdminBloc>().state;
                        final stateHapus =
                            context.watch<DataAdminHapusBloc>().state;
                        if (stateData is DataAdminLoading ||
                            stateHapus is DataAdminHapusLoading) {
                          return const LoadingWidget();
                        }
                        if (stateData is DataAdminLoadSuccess) {
                          List<DataAdminApiData> data =
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
                              return DataAdminTampil(
                                data: data[index],
                                onTapHapus: (value) async {
                                  BlocProvider.of<DataAdminHapusBloc>(
                                    context,
                                  ).add(
                                    FetchDataAdminHapus(
                                      data: value,
                                    ),
                                  );
                                },
                                onTapEdit: (value) async {
                                  var data = DataAdmin(
									idAdmin : value.idAdmin,
									nama : value.nama,
									username : value.username,
									password : value.password,
                                  );
                                  await Navigator.of(context).pushNamed(
                                    DataAdminUbahScreen.routeName,
                                    arguments: DataAdminUbahArguments(
                                      data: data,
                                      judul: "Edit Data Admin",
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        }
                        if (stateData is DataAdminLoadFailure) {
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
    BlocProvider.of<DataAdminBloc>(context).add(
      FetchDataAdmin(filter),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_peserta/bloc/data_peserta_bloc.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_apidata.dart';
import 'package:sewoapp/data_peserta/data_peserta_tambah.dart';
import 'package:sewoapp/data_peserta/data_peserta_tampil.dart';
import 'package:sewoapp/widgets/loading_widget.dart';
import 'package:sewoapp/widgets/tombol.dart';

class DataPesertaScreen extends StatefulWidget {
  static const routeName = '/data_peserta';

  const DataPesertaScreen({super.key});

  @override
  State<DataPesertaScreen> createState() => _DataPesertaScreenState();
}

class _DataPesertaScreenState extends State<DataPesertaScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DataPesertaBloc>(context)
        .add(const FetchDataPeserta(DataFilter()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Data Peserta',
          ),
        ),
        body: Stack(children: [
          ListView(
            children: [
              Image.asset(
                "assets/background_data.png",
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          Positioned(
            child: Image.asset(
              "assets/avatar.png",
              height: 100,
            ),
            right: 0,
            top: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: const Text(
                        "Silahkan Input Data Admin",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        TombolTambahWidget(
                          onPress: () {
                            Navigator.pushNamed(
                                context, DataPesertaTambahScreen.routeName);
                          },
                        ),
                        const SizedBox(width: 10),
                        TombolRefreshWidget(
                          onPress: () {
                            BlocProvider.of<DataPesertaBloc>(context)
                                .add(const FetchDataPeserta(DataFilter()));
                          },
                        ),
                        const SizedBox(width: 10),
                        TombolCariWidget(
                          onPress: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BlocListener(
                      bloc: BlocProvider.of<DataPesertaBloc>(context),
                      listener: (context, state) {},
                      child: BlocBuilder<DataPesertaBloc, DataPesertaState>(
                        builder: ((context, state) {
                          if (state is DataPesertaLoading) {
                            return const LoadingWidget();
                          }
                          if (state is DataPesertaLoadSuccess) {
                            // List<DataPesertaApiData> data = state.data.result;
                            // return ListView.builder(
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   shrinkWrap: true,
                            //   itemCount: data.length,
                            //   itemBuilder: ((context, index) {
                            //     return DataPesertaTampil(data: data[index]);
                            //   }),
                            // );
                            return Text("data");
                          }
                          if (state is DataPesertaLoadFailure) {
                            return Text('Error ${state.pesan}');
                          }
                          if (state is DataPesertaNoInternet) {
                            return NoInternetWidget();
                          }
                          return const Text('Preparing');
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}


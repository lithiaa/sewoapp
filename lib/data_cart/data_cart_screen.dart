import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_bank/bloc/data_bank_bloc.dart';
import 'package:sewoapp/data_bank/bloc/data_bank_hapus_bloc.dart';
import 'package:sewoapp/data_bank/bloc/data_bank_simpan_bloc.dart';
import 'package:sewoapp/data_bank/data/data_bank_apidata.dart';
import 'package:sewoapp/data_bank/data_bank_tampil.dart';
import 'package:sewoapp/data_bank/data_bank_tampil_select.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_hapus_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_selesai_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_simpan_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_ubah_bloc.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';
import 'package:sewoapp/data_cart/data_cart_tampil.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_apidata.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_bloc.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_hapus_bloc.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_simpan_bloc.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_apidata.dart';
import 'package:sewoapp/data_ongkir/data_ongkir_tampil.dart';
import 'package:sewoapp/data_ongkir/data_ongkir_tampil_select.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
import 'package:sewoapp/widgets/loading_widget.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/config/color.dart';
import 'package:intl/intl.dart';

class DataCartScreen extends StatefulWidget {
  static const routeName = '/data_cart';

  const DataCartScreen({super.key});

  @override
  State<DataCartScreen> createState() => _DataCartScreenState();
}

class _DataCartScreenState extends State<DataCartScreen> {
  DataFilter filter = const DataFilter();
  List<String> listPencarian = ["Hello", "Ayam"];
  String valuePencarian = "Hello";
  DataOngkirApiData? dataOngkir;
  DataBankApiData? dataBank;

  var pencarianController = TextEditingController();

  XFile? _image;

  LoginApiData? session;

  DateTime? _retrievalDate;

  @override
  void initState() {
    super.initState();
    getSession();
    _loadRetrievalDate();
  }


  Future<void> _loadRetrievalDate() async {
    final savedDate = await ConfigSessionManager.getInstance().getRetrievalDate();
    setState(() {
      _retrievalDate = savedDate ?? DateTime.now(); // Default ke hari ini jika null
    });
  }

  Future<void> clearRetrievalDate() async {
    await ConfigSessionManager.getInstance().clearRetrievalDate();
    setState(() {
      _retrievalDate = null;
    });
}


  Future<bool> _showCancelDialog() async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Batalkan Checkout'),
          content: const Text('Apakah Anda ingin membatalkan proses checkout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Tidak
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Ya
              child: const Text('Ya'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  Future<void> _deleteCartItems() async {
    final state = context.read<DataCartBloc>().state;
    if (state is DataCartLoadSuccess && !state.data.cartEmpty()) {
      final details = state.data.result.first.details!;
      for (var item in details) {
        if (item.idProduk != null) {
          print('Deleting cart item: idProduk=${item.idProduk}');
          BlocProvider.of<DataCartHapusBloc>(context).add(
            FetchDataCartHapus(data: item),
          );
          // Wait briefly to avoid overwhelming the server
          await Future.delayed(const Duration(milliseconds: 100));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldCancel = await _showCancelDialog();
        if (shouldCancel) {
          await _deleteCartItems();
          return true;
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF11316C),
        appBar: AppBar(
          title: const Text("Checkout"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final shouldCancel = await _showCancelDialog();
              if (shouldCancel) {
                await _deleteCartItems();
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<DataCartHapusBloc, DataCartHapusState>(
              listener: (context, state) {
                if (state is DataCartHapusLoadSuccess) {
                  fetchData();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Produk dihapus dari keranjang')),
                  // );
                } else if (state is DataCartHapusLoadFailure) {
                  print('Delete failed: ${state.pesan}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus produk: ${state.pesan}')),
                  );
                }
              },
            ),
            BlocListener<DataCartUbahBloc, DataCartUbahState>(
              listener: (context, state) {
                if (state is DataCartUbahLoadSuccess) {
                  fetchData();
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Jumlah produk diperbarui')),
                  // );
                } else if (state is DataCartUbahLoadFailure) {
                  print('Update failed: ${state.pesan}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal memperbarui jumlah produk: ${state.pesan}')),
                  );
                }
              },
            ),
            BlocListener<DataCartSimpanBloc, DataCartSimpanState>(
              listener: (context, state) {
                if (state is DataCartSimpanLoadSuccess) {
                  fetchData();
                }
              },
            ),
          ],
          child: Stack(
            children: [
              ListView(
                children: [
                  // Image.asset(
                  //   "assets/background_data.png",
                  //   fit: BoxFit.fitWidth,
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 80),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        dataKatalogBuilder(),

                        const SizedBox(height: 10),
                        pilihBankTujuan(),
                        const SizedBox(height: 10),


                        uploadBuktiPembayaranWidget(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Builder(
                  builder: (context) {
                    final stateData = context.watch<DataCartBloc>().state;
                    var harga = "-";
                    if (stateData is DataCartLoadSuccess) {
                      if (!stateData.data.cartEmpty()) {
                        var total = stateData.data.result.first.totalHargaProduk();
                        harga = total.toString();
                        harga = ConfigGlobal.formatRupiah(harga);
                      }
                    }

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top:10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text("Total Pembayaran"),
                                      const SizedBox(height: 3),
                                      Text(
                                        harga,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),



                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            BlocListener(
                              bloc: BlocProvider.of<DataCartSelesaiBloc>(context),
                              listener: (context, state) {
                                if (state is DataCartSelesaiLoadSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Style.buttonBackgroundColor,
                                      content: Text('Selamat, Transaksi berhasil diproses!'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: BlocBuilder<DataCartSelesaiBloc, DataCartSelesaiState>(
                                builder: (context, state) {
                                  if (state is DataCartSelesaiLoading) {
                                    return Container(
                                      width: 30,
                                      height: 30,
                                      margin: const EdgeInsets.only(right: 20),
                                      child: const CircularProgressIndicator(),
                                    );
                                  }
                                  return ElevatedButton(
                                    onPressed: !dataFormComplete()
                                        ? null
                                        : () {
                                      _onPressSelesai();
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.done_all),
                                        SizedBox(width: 3),
                                        Text("Rent"),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Builder dataKatalogBuilder() {
    return Builder(builder: (context) {
      final stateData = context.watch<DataCartBloc>().state;
      final stateHapus = context.watch<DataCartHapusBloc>().state;
      if (stateData is DataCartLoading || stateHapus is DataCartHapusLoading) {
        return const LoadingWidget();
      }
      if (stateData is DataCartLoadSuccess) {
        if (stateData.data.cartEmpty()) {
          return NoInternetWidget(
            pesan: "Tidak ada data Checkout",
          );
        }

        List<DataDetailPemesananApiData> data = stateData.data.result.first.details!;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return DataCartTampil(
              data: data[index],
              onTapHapus: (value) async {
                print('Delete button tapped: idProduk=${value.idProduk}, jumlah=${value.jumlah}');
                if (value.idProduk == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ID Produk tidak valid')),
                  );
                  return;
                }
                BlocProvider.of<DataCartHapusBloc>(context).add(
                  FetchDataCartHapus(data: value),
                );
              },
              onTapEdit: (value) async {
                print('Edit button tapped: idProduk=${value.idProduk}, jumlah=${value.jumlah}');
                if (value.idProduk == null || value.jumlah == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data produk tidak valid')),
                  );
                  return;
                }
                BlocProvider.of<DataCartUbahBloc>(context).add(
                  FetchDataCartUbah(
                    DataFilter(
                      berdasarkan: "id_produk_jumlah",
                      isi: "${value.idProduk ?? ''}|${value.jumlah ?? '1'}",
                      idPeserta: "${session!.id}",
                    ),
                  ),
                );
              },
            );
          }),
        );
      }
      if (stateData is DataCartLoadFailure) {
        return NoInternetWidget(pesan: stateData.pesan);
      }
      return NoInternetWidget();
    });
  }

  dataOngkirBuilder(context) {
    BlocProvider.of<DataOngkirBloc>(context).add(
      FetchDataOngkir(DataFilter()),
    );
    return BlocBuilder<DataOngkirBloc, DataOngkirState>(
      builder: (context, stateData) {
        if (stateData is DataOngkirLoading) {
          return const LoadingWidget();
        }
        if (stateData is DataOngkirLoadSuccess) {
          List<DataOngkirApiData> data = stateData.data.result;
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
              return DataOngkirTampilSelect(
                data: data[index],
              );
            }),
          );
        }
        if (stateData is DataOngkirLoadFailure) {
          return NoInternetWidget(pesan: stateData.pesan);
        }
        return NoInternetWidget();
      },
    );
  }

  Future<void> _showPencarianDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
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
                    items: listPencarian.map<DropdownMenuItem<String>>((String value) {
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
    session = await ConfigSessionManager.getInstance().getData();
    print('Session ID: ${session?.id}');
    if (session == null) {
      Navigator.pushNamed(context, '/login');
      return;
    }

    filter = DataFilter(berdasarkan: "id_pelanggan", isi: "${session!.id}");
    fetchData();
  }

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  void fetchData() async {
    if (session == null) {
      return;
    }

    BlocProvider.of<DataCartBloc>(context).add(
      FetchDataCart(filter),
    );
  }

  uploadBuktiPembayaranWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey[200],
      ),
      child: Column(children: [
        InkWell(
          onTap: () async {
            final ImagePicker _picker = ImagePicker();
            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
            if (image == null) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Foto tidak ditemukan'),
                ));
              }
              return;
            }
            setState(() {
              _image = image;
            });
          },
          child: Column(
            children: [
              Row(
                children: const [
                  Text("Upload Bukti Pembayaran"),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 6),
              if (_image != null) Image.file(File(_image!.path)),
            ],
          ),
        )
      ]),
    );
  }

  pilihBankTujuan() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey[200],
      ),
      child: InkWell(
          onTap: () {
            _bankTujuanTap();
          },
          child: Column(
            children: [
              Row(
                children: const [
                  Text("Metode Pembayaran"),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 6),
              if (dataBank != null)
                DataBankTampil(
                  data: dataBank!,
                  onTapEdit: (value) {},
                  onTapHapus: (value) {},
                )
            ],
          )),
    );
  }

  void _bankTujuanTap() async {
    var ongkir = await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<DataBankBloc>(
              create: (BuildContext context) => DataBankBloc(),
            ),
            BlocProvider<DataBankHapusBloc>(
              create: (BuildContext context) => DataBankHapusBloc(),
            ),
            BlocProvider<DataBankSimpanBloc>(
              create: (BuildContext context) => DataBankSimpanBloc(),
            ),
          ],
          child: StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: const Text('Bank Tujuan'),
              content: SingleChildScrollView(
                child: _dataBankBuilder(context),
              ),
            ),
          ),
        );
      },
    ) as DataBankApiData?;
    setState(() {
      dataBank = ongkir;
    });
  }

  _dataBankBuilder(context) {
    // Pastikan event fetch dipanggil
    BlocProvider.of<DataBankBloc>(context).add(
      FetchDataBank(DataFilter()),
    );

    return BlocBuilder<DataBankBloc, DataBankState>(
      builder: (context, stateData) {
        if (stateData is DataBankLoading) {
          return const LoadingWidget();
        }
        if (stateData is DataBankLoadSuccess) {
          print('Data loaded: ${stateData.data.result.length} items'); // Debug print
          List<DataBankApiData> data = stateData.data.result;
          if (data.isEmpty) {
            return const Text('Tidak ada data bank tersedia');
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                print('Building item $index: ${data[index].namaBank}'); // Debug print
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(data[index]);
                  },
                  child: DataBankTampilSelect(
                    data: data[index],
                  ),
                );
              },
            ),
          );
        }
        if (stateData is DataBankLoadFailure) {
          return Text('Error: ${stateData.pesan}');
        }
        return const Text('Initializing...');
      },
    );
  }
  bool dataFormComplete() {
    return dataBank != null && _image != null;
  }

  void _onPressSelesai() async {
    if (session == null) {
      return;
    }


    final savedDate = await ConfigSessionManager.getInstance().getRetrievalDate();

    if (savedDate == null) {
      final now = DateTime.now();
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Gunakan tanggal hari ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Pilih Tanggal Lain'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Gunakan Hari Ini'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        await ConfigSessionManager.getInstance().saveRetrievalDate(now);
      } else {
        return; // Atau tampilkan date picker
      }
    }




    final formatter = DateFormat('dd-MM-yyyy');
    var data = DataCart(
      idPelanggan: session!.id,
      idBank: dataBank!.idBank,
      idOngkir:  formatter.format(savedDate!),
      file: File(_image!.path),
    );


    BlocProvider.of<DataCartSelesaiBloc>(context).add(
      FetchDataCartSelesai(data),
    );


    ConfigSessionManager.getInstance().clearRetrievalDate();
  }
}
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
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/home/custom_bottom_navbar.dart';
import 'data/data_pemesanan.dart';


class DataPemesananScreen extends StatefulWidget {
  static const routeName = '/data_pemesanan';

  const DataPemesananScreen({super.key});

  @override
  State<DataPemesananScreen> createState() => _DataPemesananScreenState();
}

class _DataPemesananScreenState extends State<DataPemesananScreen> {
  DataFilter filter = const DataFilter();
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
          'Order History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF11316C),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
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
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              fetchData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Your Order History',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Track and manage your orders',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              fetchData();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            tooltip: 'Refresh',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Orders Content
                    Builder(builder: (context) {
                      final stateData =
                          context.watch<DataPemesananBloc>().state;
                      final stateHapus =
                          context.watch<DataPemesananHapusBloc>().state;
                      if (stateData is DataPemesananLoading ||
                          stateHapus is DataPemesananHapusLoading) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 3,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Loading orders...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      if (stateData is DataPemesananLoadSuccess) {
                        List<DataPemesananApiData> data =
                            stateData.data.result;
                        if (data.isEmpty) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 80,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'No Orders Yet',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Your order history will appear here once you place your first order.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.length} Order${data.length > 1 ? 's' : ''} Found',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: DataPemesananTampil(
                                    data: data[index],
                                    onTapHapus: (value) async {
                                      // Show confirmation dialog
                                      bool? shouldDelete = await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Delete Order'),
                                            content: const Text('Are you sure you want to delete this order?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(true),
                                                child: const Text('Delete'),
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.red,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      
                                      if (shouldDelete == true) {
                                        BlocProvider.of<DataPemesananHapusBloc>(
                                          context,
                                        ).add(
                                          FetchDataPemesananHapus(
                                            data: value,
                                          ),
                                        );
                                      }
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
                                          judul: "Edit Order",
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      }
                      if (stateData is DataPemesananLoadFailure) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 60,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Failed to Load Orders',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  stateData.pesan,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    fetchData();
                                  },
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Retry'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF11316C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.help_outline,
                                size: 60,
                                color: Colors.white70,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Something went wrong',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 3, // History tab index
        onTap: (index) {
          if (index != 3) { // Jika bukan tab History yang sedang aktif
            BottomNavHandler.handleNavigation(context, index);
          }
        },
      ),
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

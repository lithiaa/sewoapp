import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_bank/bloc/data_bank_bloc.dart';
import 'package:sewoapp/data_bank/data/data_bank_apidata.dart';
import 'package:sewoapp/data_bank/data_bank_tampil_select.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_hapus_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_selesai_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_simpan_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_ubah_bloc.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';
import 'package:sewoapp/data_cart/data_cart_tampil.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan_apidata.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_bloc.dart';
import 'package:sewoapp/data_ongkir/data/data_ongkir_apidata.dart';
import 'package:sewoapp/data_ongkir/data_ongkir_tampil_select.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
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

  // Track local quantity changes (temporarily, will be sent to API later)
  Map<String, String> _localQuantityChanges = {};

  // Promo code variables
  var promoCodeController = TextEditingController();
  bool isPromoApplied = false;
  double discountPercentage = 0.0;
  String appliedPromoCode = '';

  @override
  void initState() {
    super.initState();
    getSession();
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
          title: const Text(
            'Checkout',
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item removed from cart successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  fetchData();
                } else if (state is DataCartHapusLoadFailure) {
                  print('Delete failed: ${state.pesan}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to remove item: ${state.pesan}'),
                      backgroundColor: Colors.red,
                    ),
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
                padding: EdgeInsets.only(
                  left: 10, 
                  right: 10, 
                  bottom: isPromoApplied ? 180 + MediaQuery.of(context).padding.bottom : 100 + MediaQuery.of(context).padding.bottom,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
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
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Your Shopping Cart',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    BlocBuilder<DataCartBloc, DataCartState>(
                                      builder: (context, state) {
                                        if (state is DataCartLoadSuccess && !state.data.cartEmpty()) {
                                          final itemCount = state.data.result.first.details?.length ?? 0;
                                          return Text(
                                            '$itemCount item${itemCount > 1 ? 's' : ''} in your cart',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          );
                                        }
                                        return const Text(
                                          'Add items to your cart and complete your rental.',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        );
                                      },
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
                        dataKatalogBuilder(),

                        const SizedBox(height: 10),
                        promoCodeWidget(),
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
                        // Calculate total with current cart data
                        final cartItems = stateData.data.result.first.details!;
                        double originalTotal = _calculateTotal(cartItems);
                        double discountAmount = originalTotal * discountPercentage;
                        double finalTotal = originalTotal - discountAmount;
                        harga = finalTotal.toString();
                        harga = ConfigGlobal.formatRupiah(harga);
                      }
                    }

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 12,
                        bottom: 12 + MediaQuery.of(context).padding.bottom,
                      ),
                      child: Row(
                          children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isPromoApplied && stateData is DataCartLoadSuccess && !stateData.data.cartEmpty()) ...[
                                // Show original price with current cart data
                                Text(
                                  "Original Price",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  ConfigGlobal.formatRupiah(_calculateTotal(stateData.data.result.first.details!).toString()),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                // Show discount
                                Text(
                                  "Discount (${(discountPercentage * 100).toInt()}%)",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  "- ${ConfigGlobal.formatRupiah((_calculateTotal(stateData.data.result.first.details!) * discountPercentage).toString())}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                              ],
                              const Text(
                                "Payment Total",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                harga,
                                style: TextStyle(
                                  fontSize: isPromoApplied ? 18 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          BlocListener(
                            bloc: BlocProvider.of<DataCartSelesaiBloc>(context),
                            listener: (context, state) {
                              if (state is DataCartSelesaiLoadSuccess) {
                                // Clear local quantity changes on successful checkout
                                setState(() {
                                  _localQuantityChanges.clear();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Style.buttonBackgroundColor,
                                    content: Text('Rental confirmed successfully!'),
                                  ),
                                );
                                Navigator.of(context).pop();
                              } else if (state is DataCartSelesaiLoadFailure) {
                                print('Rental failed: ${state.pesan}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Rental failed: ${state.pesan}'),
                                  ),
                                );
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
                                  onPressed: () {
                                    if (!dataFormComplete()) {
                                      // Show what's missing for payment
                                      List<String> missing = [];
                                      if (dataBank == null) missing.add('Payment Method');
                                      if (_image == null) missing.add('Payment Proof');
                                      
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Please select: ${missing.join(', ')}'),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    } else {
                                      print('Rent button pressed - calling _onPressSelesai');
                                      _onPressSelesai();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: dataFormComplete() 
                                        ? const Color(0xFF11316C) 
                                        : Colors.grey,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(dataFormComplete() ? Icons.handshake : Icons.warning),
                                      const SizedBox(width: 3),
                                      Text(dataFormComplete() ? "Confirm Rental" : "Complete Info"),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                  'Loading cart...',
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
      
      if (stateData is DataCartLoadSuccess) {
        if (stateData.data.cartEmpty()) {
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
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.white70,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your Cart is Empty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some products to your cart to proceed with checkout.',
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

        List<DataDetailPemesananApiData> data = stateData.data.result.first.details!;

        return ListView.builder(
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
              child: DataCartTampil(
                data: _getItemWithLocalQuantity(data[index]), // Use item with local quantity changes
                onTapHapus: (value) async {
                  print('Delete button tapped: idDetailPemesanan=${value.idDetailPemesanan}, idProduk=${value.idProduk}');
                  if (value.idDetailPemesanan == null && value.idProduk == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cannot delete: Invalid item data'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  
                  // Show confirmation dialog
                  bool? shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Remove Item'),
                        content: const Text('Are you sure you want to remove this item from cart?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Remove'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  
                  if (shouldDelete == true) {
                    // Show loading indicator
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Removing item...'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    
                    print('Calling delete API with getIdHapus: ${value.getIdHapus()}');
                    BlocProvider.of<DataCartHapusBloc>(context).add(
                      FetchDataCartHapus(data: value),
                    );
                  }
                },
                onTapEdit: (value) async {
                  print('Edit button tapped: idProduk=${value.idProduk}, jumlah=${value.jumlah}');
                  if (value.idProduk == null || value.jumlah == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid product data')),
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
                onQuantityChanged: (value) {
                  // Update quantity locally without API call
                  print('Quantity changed locally for ${value.idProduk}: ${value.jumlah}');
                  setState(() {
                    _localQuantityChanges[value.idProduk ?? ''] = value.jumlah ?? '1';
                  });
                  print('Local quantity changes: $_localQuantityChanges');
                },
              ),
            );
          }),
        );
      }
      
      if (stateData is DataCartLoadFailure) {
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
                  'Failed to Load Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Data format error. Please try again.',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                if (stateData.pesan.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Error: ${stateData.pesan}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
    });
  }

  BlocBuilder<DataOngkirBloc, DataOngkirState> dataOngkirBuilder(context) {
    BlocProvider.of<DataOngkirBloc>(context).add(
      FetchDataOngkir(DataFilter()),
    );
    return BlocBuilder<DataOngkirBloc, DataOngkirState>(
      builder: (context, stateData) {
        if (stateData is DataOngkirLoading) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading shipping options...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }
        if (stateData is DataOngkirLoadSuccess) {
          List<DataOngkirApiData> data = stateData.data.result;
          if (data.isEmpty) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'No shipping options available',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${stateData.pesan}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Initializing...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  bool dataFormComplete() {
    return dataBank != null && _image != null;
  }

  void _onPressSelesai() async {
    print('_onPressSelesai called');
    
    if (session == null) {
      print('Session is null, cannot proceed');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to continue'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!dataFormComplete()) {
      print('Form not complete: dataBank=${dataBank != null}, image=${_image != null}');
      return;
    }

    // Get current cart data
    final stateData = context.read<DataCartBloc>().state;
    if (stateData is! DataCartLoadSuccess || stateData.data.cartEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cart is empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print('Checking saved date...');
    final savedDate = await ConfigSessionManager.getInstance().getRetrievalDate();

    // Use saved date if available, otherwise use today's date
    final finalDate = savedDate ?? DateTime.now();
    
    // Save today's date if no date was previously saved
    if (savedDate == null) {
      print('No saved date, using today\'s date');
      await ConfigSessionManager.getInstance().saveRetrievalDate(finalDate);
    }
    print('Using date: $finalDate');

    // Update quantities in database before checkout if there are local changes
    if (_localQuantityChanges.isNotEmpty) {
      print('Updating quantities in database before checkout...');
      await _updateQuantitiesBeforeCheckout();
    }

    final formatter = DateFormat('dd-MM-yyyy');
    
    // Prepare cart data with all items
    var data = DataCart(
      idPelanggan: session!.id,
      idBank: dataBank!.idBank,
      idOngkir: formatter.format(finalDate),
      file: File(_image!.path),
    );

    // Get all cart items and apply local quantity changes
    final cartItems = stateData.data.result.first.details!;
    List<Map<String, dynamic>> detailItems = [];
    
    print('Processing ${cartItems.length} cart items with local changes: $_localQuantityChanges');
    
    for (var item in cartItems) {
      String originalQuantity = item.jumlah ?? '1';
      String finalQuantity = originalQuantity;
      
      // Apply local quantity changes if exists
      if (_localQuantityChanges.containsKey(item.idProduk)) {
        finalQuantity = _localQuantityChanges[item.idProduk!]!;
        print('Item ${item.idProduk}: original quantity=$originalQuantity, updated quantity=$finalQuantity');
      } else {
        print('Item ${item.idProduk}: using original quantity=$originalQuantity');
      }
      
      detailItems.add({
        'id_produk': item.idProduk,
        'jumlah': finalQuantity,
        'harga': item.harga,
      });
    }

    print('Final detail items to send: $detailItems');

    print('Submitting checkout with ${detailItems.length} items');
    print('Cart completion with data - idPelanggan: ${data.idPelanggan}, idBank: ${data.idBank}');
    
    // Show loading message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Processing rental and payment...'),
        duration: Duration(seconds: 3),
      ),
    );

    // Send data with detail items to be processed
    BlocProvider.of<DataCartSelesaiBloc>(context).add(
      FetchDataCartSelesaiWithDetails(data, detailItems),
    );

    await ConfigSessionManager.getInstance().clearRetrievalDate();
    print('Cart completion process initiated');
  }

  // Update quantities in database before checkout
  Future<void> _updateQuantitiesBeforeCheckout() async {
    if (_localQuantityChanges.isEmpty) {
      print('No local quantity changes to update');
      return;
    }
    
    print('Updating ${_localQuantityChanges.length} quantity changes before checkout');
    
    for (var entry in _localQuantityChanges.entries) {
      String idProduk = entry.key;
      String newQuantity = entry.value;
      
      try {
        print('Updating quantity for product $idProduk to $newQuantity');
        BlocProvider.of<DataCartUbahBloc>(context).add(
          FetchDataCartUbah(
            DataFilter(
              berdasarkan: "id_produk_jumlah",
              isi: "$idProduk|$newQuantity",
              idPeserta: "${session!.id}",
            ),
          ),
        );
        
        // Wait a bit to avoid overwhelming the server
        await Future.delayed(const Duration(milliseconds: 300));
      } catch (e) {
        print('Failed to update quantity for product $idProduk: $e');
      }
    }
    
    // Wait for all updates to complete
    await Future.delayed(const Duration(seconds: 1));
    
    // Refresh cart data to get updated quantities
    fetchData();
    
    // Wait for refresh to complete
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _applyPromoCode() {
    String code = promoCodeController.text.trim().toUpperCase();
    
    if (code == 'SEWOSEWOSEWO') {
      setState(() {
        isPromoApplied = true;
        discountPercentage = 0.20; // 20% discount
        appliedPromoCode = code;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Promo code applied! 20% discount'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a promo code'),
          backgroundColor: Colors.orange,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid promo code'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removePromoCode() {
    setState(() {
      isPromoApplied = false;
      discountPercentage = 0.0;
      appliedPromoCode = '';
      promoCodeController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Promo code removed'),
        backgroundColor: Colors.grey,
      ),
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
    promoCodeController.dispose();
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

  Container uploadBuktiPembayaranWidget() {
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
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
            if (image == null) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Photo not found'),
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
                  Text("Upload Payment Proof"),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 6),
              if (_image != null) 
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(_image!.path),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        )
      ]),
    );
  }

  Container pilihBankTujuan() {
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
                  Text("Payment Method"),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 6),
              if (dataBank != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataBank!.namaBank ?? 'Bank Name',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (dataBank!.rekening != null)
                              Text(
                                dataBank!.rekening!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          )),
    );
  }

  Container promoCodeWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.local_offer, size: 20, color: Colors.green),
              SizedBox(width: 8),
              Text(
                "Promo Code",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isPromoApplied) ...[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promoCodeController,
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _applyPromoCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Promo Applied: $appliedPromoCode',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          '${(discountPercentage * 100).toInt()}% discount',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _removePromoCode,
                    icon: const Icon(Icons.close, color: Colors.red, size: 20),
                    tooltip: 'Remove promo code',
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _bankTujuanTap() async {
    var selectedBank = await showDialog<DataBankApiData>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BlocProvider<DataBankBloc>(
          create: (context) => DataBankBloc()..add(FetchDataBank(DataFilter())),
          child: AlertDialog(
            title: const Text('Select Payment Method'),
            content: SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.6,
              child: BlocBuilder<DataBankBloc, DataBankState>(
                builder: (context, stateData) {
                  if (stateData is DataBankLoading) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading payment methods...'),
                        ],
                      ),
                    );
                  }
                  if (stateData is DataBankLoadSuccess) {
                    List<DataBankApiData> data = stateData.data.result;
                    if (data.isEmpty) {
                      return const Center(
                        child: Text('No payment methods available'),
                      );
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(dialogContext).pop(data[index]);
                          },
                          child: DataBankTampilSelect(
                            data: data[index],
                          ),
                        );
                      },
                    );
                  }
                  if (stateData is DataBankLoadFailure) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text('Error: ${stateData.pesan}'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<DataBankBloc>(context).add(
                                FetchDataBank(DataFilter()),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: Text('Initializing...'),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
    
    if (selectedBank != null) {
      setState(() {
        dataBank = selectedBank;
      });
    }
  }

  // Helper method to get cart item with local quantity changes applied
  DataDetailPemesananApiData _getItemWithLocalQuantity(DataDetailPemesananApiData originalItem) {
    String currentQuantity = originalItem.jumlah ?? '1';
    
    // Apply local quantity changes if exists
    if (_localQuantityChanges.containsKey(originalItem.idProduk)) {
      currentQuantity = _localQuantityChanges[originalItem.idProduk!]!;
      print('Using local quantity for ${originalItem.idProduk}: $currentQuantity (original: ${originalItem.jumlah})');
    }
    
    // Return item with updated quantity
    return DataDetailPemesananApiData(
      idDetailPemesanan: originalItem.idDetailPemesanan,
      idPemesanan: originalItem.idPemesanan,
      idProduk: originalItem.idProduk,
      jumlah: currentQuantity,
      harga: originalItem.harga,
      namaProduk: originalItem.namaProduk,
      gambar: originalItem.gambar,
    );
  }

  // Calculate total price with local quantity changes
  double _calculateTotal(List<DataDetailPemesananApiData> cartItems) {
    double total = 0.0;
    
    for (var item in cartItems) {
      String quantity = item.jumlah ?? '1';
      
      // Apply local quantity changes if exists
      if (_localQuantityChanges.containsKey(item.idProduk)) {
        quantity = _localQuantityChanges[item.idProduk!]!;
      }
      
      double price = double.tryParse(item.harga ?? '0') ?? 0.0;
      int qty = int.tryParse(quantity) ?? 1;
      
      total += (price * qty);
    }
    
    return total;
  }
}
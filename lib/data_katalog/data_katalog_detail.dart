import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_simpan_bloc.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';
import 'package:sewoapp/data_cart/data_cart_screen.dart';
import 'package:sewoapp/data_detail_pemesanan/data/data_detail_pemesanan.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_apidata.dart';
import 'package:sewoapp/home/chat_page.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

class DataKatalogDetail extends StatefulWidget {
  static const routeName = "data_katalog/detail";

  const DataKatalogDetail({super.key});

  @override
  State<DataKatalogDetail> createState() => _DataKatalogDetailState();
}

class _DataKatalogDetailState extends State<DataKatalogDetail> {
  bool showHarga = false;

  // Fallback JSON data with dash values
  final Map<String, dynamic> informasi_detail = {
    "specification": {
      "engine": "-",
      "fuel": "-",
      "top_speed": "-"
    },
    "vehicle_features": [
      {"icon": "-", "text": "-"},
      {"icon": "-", "text": "-"},
      {"icon": "-", "text": "-"},
      {"icon": "-", "text": "-"}
    ],
    "additional_information": [
      {
        "icon": "-",
        "title": "-",
        "description": "-"
      },
      {
        "icon": "-",
        "title": "-",
        "description": "-"
      },
      {
        "icon": "-",
        "title": "-",
        "description": [
          {"type": "-", "value": "-"},
          {"type": "-", "value": "-", "url": "-"},
          {"type": "-", "value": "-"},
          {"type": "-", "value": "-"}
        ]
      }
    ]
  };

  Map<String, dynamic> _getDetailData(DataKatalogApiData data) {
    if (data.deskripsi == null || data.deskripsi!.isEmpty) {
      debugPrint("Failed to load JSON: deskripsi is null or empty");
      return informasi_detail;
    }

    try {
      final parsedJson = jsonDecode(data.deskripsi!);
      if (parsedJson is Map<String, dynamic> &&
          parsedJson.containsKey('specification') &&
          parsedJson.containsKey('vehicle_features') &&
          parsedJson.containsKey('additional_information') &&
          parsedJson['specification'] is Map &&
          parsedJson['vehicle_features'] is List &&
          parsedJson['additional_information'] is List) {
        return parsedJson;
      } else {
        debugPrint("Failed to load JSON: invalid format, missing or incorrect required keys");
        return informasi_detail;
      }
    } catch (e) {
      debugPrint("Failed to load JSON: parsing error - $e");
      return informasi_detail;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  // Function to check if engine is electric
  bool _isElectricEngine(String? engine) {
    if (engine == null) return false;
    return engine.toLowerCase().contains('electric');
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as DataKatalogApiData;
    final detailData = _getDetailData(data);
    final specification = detailData['specification'] as Map<String, dynamic>? ?? {};
    final vehicleFeatures = detailData['vehicle_features'] as List<dynamic>? ?? [];
    final additionalInformation = detailData['additional_information'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
            appBar: AppBar(
        title: Text(
          data.namaProduk ?? "",
          style: const TextStyle(
            color: Colors.white,
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
      body: BlocListener(
        bloc: BlocProvider.of<DataCartSimpanBloc>(context),
        listener: (context, state) {
          if (state is DataCartSimpanLoadSuccess) {
            fetchCart();
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(DataCartScreen.routeName);
          } else if (state is DataCartSimpanLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gagal menambahkan ke keranjang')),
            );
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: showHarga ? 115 : 75),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section with partner info
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        color: const Color(0xFFF2F6FF),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Partner info at top
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.store,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    data.namaPartner ?? 'Unknown Partner',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Hero image
                              Hero(
                                tag: "${data.namaProduk}",
                                child: Image.network(
                                  "${ConfigGlobal.baseUrl}/admin/upload/${data.gambar}",
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/image-not-available.jpg",
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width * 0.4,
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Product info section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        color: const Color(0xFFF2F6FF),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.namaProduk ?? "-",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      data.kategori ?? "-",
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 8),
                                    // Rating dummy
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          '4.0 (24 reviews)',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  VisibilityDetector(
                                    key: const Key("harga"),
                                    onVisibilityChanged: (VisibilityInfo info) {
                                      var visiblePercentage = info.visibleFraction * 100;
                                      if (mounted) {
                                        setState(() {
                                          showHarga = visiblePercentage == 0.0;
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          ConfigGlobal.formatRupiah(data.harga),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Style.buttonBackgroundColor,
                                          ),
                                        ),
                                        const Text(
                                          "/day",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Style.buttonBackgroundColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Specifications section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        color: const Color(0xFFF2F6FF),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Specification",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.settings, size: 24),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Engine",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(specification['engine']?.toString() ?? "-"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              _isElectricEngine(specification['engine']?.toString()) 
                                                ? Icons.battery_charging_full 
                                                : Icons.local_gas_station, 
                                              size: 24
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              _isElectricEngine(specification['engine']?.toString()) 
                                                ? "Battery" 
                                                : "Fuel",
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(specification['fuel']?.toString() ?? "-"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.speed, size: 24),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Top Speed",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(specification['top_speed']?.toString() ?? "-"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Vehicle Features section  
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        color: const Color(0xFFF2F6FF),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Vehicle Features",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ..._buildVehicleFeatures(vehicleFeatures),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Additional Information section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        color: const Color(0xFFF2F6FF),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Additional Information",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on_outlined, color: Colors.black54),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Jl. Kayu Manis Timur No.24, Matram, Jakarta Timur',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ..._buildAdditionalInformation(additionalInformation),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // User Review section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        color: const Color(0xFFF2F6FF),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'User Review',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.account_circle_rounded, size: 40, color: Colors.black),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Muhammad Agusdin',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: List.generate(
                                            5,
                                            (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        const Text(
                                          'Kendaraanya terawat dengan baik sehingga enak pada waktu digunakan, tata cara menyewa kendaraannya juga mudah.',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      renterName: data.namaPartner ?? "Unknown Partner",
                                    ),
                                  ),
                                );
                              },
                              splashColor: Colors.grey[400],
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: const Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        color: Colors.black87,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Chat",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                print('Rent button tapped');
                                _tambahKeranjang(data);
                              },
                              splashColor: Colors.blue[200],
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Style.buttonBackgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.car_rental,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "Rent",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildVehicleFeatures(List<dynamic> features) {
    List<Widget> rows = [];
    for (int i = 0; i < features.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(_getIcon(features[i]['icon']?.toString()), size: 24),
                      const SizedBox(width: 8),
                      Text(features[i]['text']?.toString() ?? "-"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (i + 1 < features.length)
              Expanded(
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(_getIcon(features[i + 1]['icon']?.toString()), size: 24),
                        const SizedBox(width: 8),
                        Text(features[i + 1]['text']?.toString() ?? "-"),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
      rows.add(const SizedBox(height: 8));
    }
    return rows;
  }

  List<Widget> _buildAdditionalInformation(List<dynamic> infoList) {
    return infoList.map((info) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_getIcon(info['icon']?.toString()), size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info['title']?.toString() ?? "-",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (info['description'] is String)
                      Text(info['description']?.toString() ?? "-")
                    else if (info['description'] is List)
                      ..._buildDescriptionItems(info['description'] as List<dynamic>),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      );
    }).toList();
  }

  List<Widget> _buildDescriptionItems(List<dynamic> items) {
    return items.map<Widget>((item) {
      if (item['type']?.toString() == 'link') {
        return InkWell(
          onTap: () async {
            final url = Uri.parse(item['url']?.toString() ?? '');
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gagal membuka tautan')),
                );
              }
            }
          },
          child: Text(
            item['value']?.toString() ?? "-",
            style: const TextStyle(color: Colors.blue),
          ),
        );
      }
      return Text(item['value']?.toString() ?? "-");
    }).toList();
  }

  IconData _getIcon(String? iconName) {
    switch (iconName) {
      case 'group':
        return Icons.group;
      case 'door_front_door':
        return Icons.door_front_door;
      case 'book':
        return Icons.book;
      case 'gps_fixed':
        return Icons.gps_fixed;
      case 'access_time':
        return Icons.access_time;
      case 'info':
        return Icons.info;
      case 'support_agent':
        return Icons.support_agent;
      default:
        return Icons.info;
    }
  }

  void fetchCart() async {
    var session = await ConfigSessionManager.getInstance().getData();
    if (session == null) {
      return;
    }

    DataFilter data = DataFilter(
      berdasarkan: "id_pelanggan",
      isi: session.id.toString(),
    );
    if (mounted) {
      BlocProvider.of<DataCartBloc>(context).add(FetchDataCart(data));
    }
  }

  void _tambahKeranjang(DataKatalogApiData data) async {
    var session = await ConfigSessionManager.getInstance().getData();

    if (session == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan login terlebih dahulu')),
        );
      }
      return;
    }

    BlocProvider.of<DataCartSimpanBloc>(context).add(
      FetchDataCartSimpan(
        DataCart(
          idPelanggan: session.id,
          idOngkir: "",
          idBank: "",
          uploadBuktiPembayaran: "",
          detail: DataDetailPemesanan(
            jumlah: "1",
            idProduk: data.idProduk,
            harga: data.harga,
          ),
        ),
      ),
    );
  }
}
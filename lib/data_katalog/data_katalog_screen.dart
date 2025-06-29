import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_bloc.dart';
import 'package:sewoapp/data_cart/data_cart_screen.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_bloc.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_event.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_state.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_apidata.dart';
import 'package:sewoapp/data_katalog/data_katalog_tampil.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
import 'package:sewoapp/widgets/loading_widget.dart';
import 'package:sewoapp/home/custom_bottom_navbar.dart';
import '../config/config_global.dart';
import 'package:sewoapp/config/color.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataKatalogScreen extends StatefulWidget {
  static const routeName = "data_katalog";

  const DataKatalogScreen({super.key});

  @override
  State<DataKatalogScreen> createState() => _DataKatalogScreenState();
}

class _DataKatalogScreenState extends State<DataKatalogScreen> {
  late TextEditingController pencarianController;
  late FilterKatalog filter;
  final stream = BehaviorSubject<String>();
  LoginApiData? user;
  String currentCategory = '';
  String? selectedArea;
  List<String> areas = [];
  bool isLoadingAreas = true;

  @override
  void initState() {
    super.initState();

    pencarianController = TextEditingController();
    filter = FilterKatalog(berdasarkan: "nama_produk", type: "semua");

    stream.debounceTime(const Duration(milliseconds: 500)).listen((value) {
      filter.isi = value;
      BlocProvider.of<DataKatalogBloc>(context).add(FetchDataKatalog(filter));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (routeArgs != null) {
        currentCategory = routeArgs['category'] ?? '';
        final searchText = routeArgs['searchText'] ?? '';

        pencarianController.text = searchText;
        filter = FilterKatalog(
          berdasarkan: "nama_produk",
          type: searchText.isNotEmpty ? 'semua' : (currentCategory == 'all' ? 'semua' : 'kategori'),
          isi: searchText,
        );
        stream.add(searchText);
      }

      BlocProvider.of<DataKatalogBloc>(context).add(FetchDataKatalog(filter));
    });

    fetchCart();
    getData();
    fetchAreas();
  }

  @override
  void dispose() {
    stream.close();
    pencarianController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    var data = await ConfigSessionManager.getInstance().getData();
    if (mounted) {
      if (data == null) {
        Navigator.of(context).pop();
        return;
      }
      user = data;
    }
  }

  Future<void> fetchAreas() async {
    try {
      final response = await http.get(
        Uri.parse('${ConfigGlobal.baseUrl}area.php'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            areas = List<String>.from(data);
            isLoadingAreas = false;
          });
        }
      } else {
        throw Exception('Failed to load areas');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingAreas = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading areas: $e')),
        );
      }
    }
  }

  void _showAreaSelectionModal(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalContext) {
        return Container(
          height: MediaQuery.of(modalContext).size.height * 0.5,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Area',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: isLoadingAreas
                    ? const Center(child: CircularProgressIndicator())
                    : areas.isEmpty
                    ? const Center(child: Text('No areas available'))
                    : CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return ListTile(
                            title: Text(areas[index]),
                            onTap: () {
                              setState(() {
                                selectedArea = areas[index];
                                pencarianController.text = 'AREA ${areas[index].toUpperCase()}';
                                filter.type = 'semua'; // Ensure broad search
                                stream.add(pencarianController.text);
                              });
                              Navigator.pop(modalContext);
                            },
                          );
                        },
                        childCount: areas.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11316C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<DataKatalogBloc>(context).add(FetchDataKatalog(filter));
              if (user != null) {
                // Your existing user check logic
              }
              await fetchCart();
              await fetchAreas();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => _showAreaSelectionModal(context),
                      child: Row(
                        children: [
                          const Text(
                            'Select location',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: pencarianController,
                      onChanged: (value) {
                        filter.type = 'semua'; // Ensure broad search
                        stream.add(value);
                      },
                      onFieldSubmitted: (value) {
                        filter.type = 'semua'; // Ensure broad search
                        stream.add(value);
                      },
                      textInputAction: TextInputAction.search,
                      cursorColor: Style.buttonBackgroundColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Pencarian',
                        hintStyle: const TextStyle(color: Colors.black54),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: BlocBuilder<DataCartBloc, DataCartState>(
                        builder: (context, state) {
                          return Container(
                            width: 45,
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(DataCartScreen.routeName);
                              },
                              child: badges.Badge(
                                badgeContent: Text(
                                  state is DataCartLoadSuccess && state.data.result.isNotEmpty
                                      ? "${state.data.result.first.totalProduk()}"
                                      : "0",
                                  style: const TextStyle(fontSize: 11),
                                ),
                                child: const Icon(Icons.shopping_cart),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    BlocListener(
                      bloc: BlocProvider.of<DataKatalogBloc>(context),
                      listener: (context, state) {},
                      child: BlocBuilder<DataKatalogBloc, DataKatalogState>(
                        builder: ((context, state) {
                          if (state is DataKatalogLoading) {
                            return const LoadingWidget();
                          }
                          if (state is DataKatalogLoadSuccess) {
                            List<DataKatalogApiData> data = state.data.result;
                            if (data.isEmpty) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                        Icons.search_off_rounded,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        currentCategory.isNotEmpty
                                            ? 'Pencarian ${filter.isi.isNotEmpty ? filter.isi : currentCategory} Tidak Ditemukan'
                                            : 'Produk tidak ditemukan',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: ((context, index) {
                                return DataKatalogTampil(data: data[index]);
                              }),
                            );
                          }
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                    Icons.search_off_rounded,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    currentCategory.isNotEmpty
                                        ? 'Pencarian ${filter.isi.isNotEmpty ? filter.isi : currentCategory} Tidak Ditemukan'
                                        : 'Produk tidak ditemukan',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 1, // Products tab index
        onTap: (index) {
          if (index != 1) { // Jika bukan tab Products yang sedang aktif
            BottomNavHandler.handleNavigation(context, index);
          }
        },
      ),
    );
  }

  Future<void> fetchCart() async {
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
}
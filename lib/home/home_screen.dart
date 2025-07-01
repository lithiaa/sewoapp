import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_bloc.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_event.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_state.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_apidata.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/home/ekatalog.dart';
import 'package:sewoapp/home/home_app.dart';
import 'package:sewoapp/home/judul_ekatalog.dart';
import 'package:sewoapp/home/judul_promotion.dart';
import 'package:sewoapp/home/pencarian.dart';
import 'package:sewoapp/home/promo_card.dart';
import 'package:sewoapp/home/popular_card.dart';
import 'package:sewoapp/home/custom_carousel_slider.dart';
import 'package:sewoapp/home/location_account_header.dart';
import 'package:sewoapp/home/custom_bottom_navbar.dart';
import 'package:sewoapp/login/login_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';



class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<DataKatalogApiData> dataTerlaris = [];
  List<DataKatalogApiData> dataTerbaru = [];
  final GlobalKey<LocationAccountHeaderState> _headerKey = GlobalKey<LocationAccountHeaderState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<DataKatalogBloc>(context)
        .add(FetchDataKatalog(FilterKatalog(type: "terbaru")));

    Future.delayed(const Duration(seconds: 3), () {
      BlocProvider.of<DataKatalogBloc>(context)
          .add(FetchDataKatalog(FilterKatalog(type: "terlaris")));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh header ketika app kembali ke foreground
      _headerKey.currentState?.refreshLoginStatus();
    }
  }


  void _navigateToKatalog(String category, String searchText) {
    Navigator.of(context).pushNamed(
      DataKatalogScreen.routeName,
      arguments: {
        'category': category,
        'searchText': searchText,
      },
    );
  }

  String _getRandomPromotionImage() {
    final random = Random();
    final promotionImages = [
      'assets/promotion_home/promotion_home_1.png',
      'assets/promotion_home/promotion_home_2.png',
    ];
    return promotionImages[random.nextInt(promotionImages.length)];
  }

  Future<void> _refreshData() async {
    // Refresh header login status
    _headerKey.currentState?.refreshLoginStatus();
    
    // Clear existing data
    setState(() {
      dataTerlaris.clear();
      dataTerbaru.clear();
    });
    
    // Reload catalog data
    BlocProvider.of<DataKatalogBloc>(context)
        .add(FetchDataKatalog(FilterKatalog(type: "terbaru")));
    
    // Delay untuk terlaris seperti di initState
    await Future.delayed(const Duration(seconds: 1));
    BlocProvider.of<DataKatalogBloc>(context)
        .add(FetchDataKatalog(FilterKatalog(type: "terlaris")));
    
    // Tunggu sebentar untuk loading selesai
    await Future.delayed(const Duration(milliseconds: 500));
  }


  @override
  Widget build(BuildContext context) {
    cekLogin();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF11316C),
      /* appBar: MyAppBar(), */
      drawerEnableOpenDragGesture: false,
      // drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Header dengan informasi lokasi dan akun
                  LocationAccountHeader(key: _headerKey),
                  const Pencarian(), //box pencarian
                ],
              ),
            ),

            //banner iklan atas
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(_getRandomPromotionImage()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Area overlap antara biru dan putih
            Stack(
              children: [
                // Background putih bagian bawah
                Container(
                  margin: const EdgeInsets.only(top: 45),
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                ),
                // HomeApp di tengah-tengah (irisan) - benar-benar overlap
                Positioned(
                  top: 0, // Tepat di tengah: 50% di biru, 50% di putih
                  left: 0,
                  right: 0,
                  child: HomeApp(scaffoldKey: scaffoldKey),
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
              color: Colors.white,
              ),
              child:  ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  const SizedBox(height: 10),
                  JudulEPromotioan(judul: "Promotions for you"),
                  const SizedBox(height: 0),
                  const CustomCarouselSlider(),
                  const SizedBox(height: 5),
                  PromoCard(category: 'SeMolis', searchText: 'SeMolis'),
                  const SizedBox(height: 10),
                  JudulEPromotioan(judul: "Popular Tourism"),
                  const SizedBox(height: 10),
                  PopularTourism(
                    onDestinationTap: _navigateToKatalog,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    child: Column(
                      children: [
                        // Nearby Car Section
                        const SizedBox(height: 10),
                        JudulEkatalog(judul: "Car", filter: "SeMobil"),
                        const SizedBox(height: 0),
                        BlocListener(
                          bloc: BlocProvider.of<DataKatalogBloc>(context),
                          listener: (context, state) {},
                          child: BlocBuilder<DataKatalogBloc, DataKatalogState>(
                            builder: ((context, state) {
                              if (state is! DataKatalogLoadSuccess) {
                                return _buildShimmerList();
                              }

                              if (state.type.toLowerCase().trim().contains("terbaru")) {
                                dataTerbaru = state.data.result; // Ambil semua data dulu
                              }

                              // Filter hanya untuk mobil
                              List<DataKatalogApiData> carData = dataTerbaru
                                  .where((item) => item.kategori?.toLowerCase().contains('mobil') == true)
                                  .toList();

                              return _buildProductList(carData.take(5).toList());
                            }),
                          ),
                        ),
                        
                        // Nearby Motorcycle Section
                        const SizedBox(height: 20),
                        JudulEkatalog(judul: "Motorcycle", filter: "SeMotor"),
                        const SizedBox(height: 0),
                        BlocBuilder<DataKatalogBloc, DataKatalogState>(
                          builder: ((context, state) {
                            if (state is! DataKatalogLoadSuccess) {
                              return _buildShimmerList();
                            }

                            List<DataKatalogApiData> motorcycleData = dataTerbaru
                                .where((item) => item.kategori?.toLowerCase().contains('motor') == true)
                                .toList();

                            return _buildProductList(motorcycleData.take(5).toList());
                          }),
                        ),

                        // Nearby Electric Vehicle Section
                        const SizedBox(height: 20),
                        JudulEkatalog(judul: "Electric vehicle", filter: "SeMolis"),
                        const SizedBox(height: 0),
                        BlocBuilder<DataKatalogBloc, DataKatalogState>(
                          builder: ((context, state) {
                            if (state is! DataKatalogLoadSuccess) {
                              return _buildShimmerList();
                            }

                            List<DataKatalogApiData> electricData = dataTerbaru
                                .where((item) => item.kategori?.toLowerCase().contains('molis') == true)
                                .toList();

                            return _buildProductList(electricData.take(5).toList());
                          }),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // BlocBuilder<DataKatalogBloc, DataKatalogState>(
            //     builder: (context, state) {
            //   }
            //   return Text("");
            // }),
          ],
        ),
      ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 0,
        onTap: (index) => BottomNavHandler.handleNavigation(context, index),
      ),
    );
  }

  void cekLogin() async {
    if (!ConfigGlobal.login) return;
    final session = ConfigSessionManager.getInstance();
    final sudahLogin = await session.sudahLogin();
    if (sudahLogin) return;
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  Widget _buildShimmerList() {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        enabled: true,
                        baseColor: Colors.white,
                        highlightColor: Colors.grey,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            color: Colors.white,
                          ),
                          height: 170,
                          width: 180,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Shimmer.fromColors(
                        enabled: true,
                        baseColor: Colors.white,
                        highlightColor: Colors.grey,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 20,
                          width: 180,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Shimmer.fromColors(
                        enabled: true,
                        baseColor: Colors.white,
                        highlightColor: Colors.grey,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            color: Colors.white,
                          ),
                          height: 20,
                          width: 180,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductList(List<DataKatalogApiData> products) {
    if (products.isEmpty) {
      return Container(
        height: 250,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Tidak ada produk tersedia',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Ekatalog(data: products[index]);
          },
        ),
      ),
    );
  }
}

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

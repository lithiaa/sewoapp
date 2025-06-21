import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_bloc.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_event.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_state.dart';
import 'package:sewoapp/data_katalog/data/data_katalog_apidata.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_ubah.dart';
import 'package:sewoapp/data_pemesanan/data_pemesanan_screen.dart';
import 'package:sewoapp/home/ekatalog.dart';
import 'package:sewoapp/home/home_app.dart';
import 'package:sewoapp/home/judul_ekatalog.dart';
import 'package:sewoapp/home/judul_promotion.dart';
import 'package:sewoapp/home/pencarian.dart';
import 'package:sewoapp/home/promo_card.dart';
import 'package:sewoapp/home/popular_card.dart';
import 'package:sewoapp/home/about_card.dart';
import 'package:sewoapp/home/custom_carousel_slider.dart';
import 'package:sewoapp/login/login_screen.dart';
import 'package:sewoapp/widgets/slider_widget.dart';
import 'package:shimmer/shimmer.dart';



class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<DataKatalogApiData> dataTerlaris = [];
  List<DataKatalogApiData> dataTerbaru = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DataKatalogBloc>(context)
        .add(FetchDataKatalog(FilterKatalog(type: "terbaru")));

    Future.delayed(const Duration(seconds: 5), () {
      BlocProvider.of<DataKatalogBloc>(context)
          .add(FetchDataKatalog(FilterKatalog(type: "terlaris")));
    });
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


  @override
  Widget build(BuildContext context) {
    cekLogin();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF11316C),
      /* appBar: MyAppBar(), */
      drawerEnableOpenDragGesture: false,
      // drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Image.asset(
                  'assets/background.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [

                const SizedBox(height: 5),
                const Pencarian(),
                HomeApp(scaffoldKey: scaffoldKey),
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/linear.png'),
                      fit: BoxFit.cover,
                      opacity: 0.9,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      JudulEkatalog(judul: "Special recommendation"),
                      const SizedBox(height: 0),
                      BlocListener(
                        bloc: BlocProvider.of<DataKatalogBloc>(context),
                        listener: (context, state) {},
                        child: BlocBuilder<DataKatalogBloc, DataKatalogState>(
                          builder: ((context, state) {
                            if (state is! DataKatalogLoadSuccess) {
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
                                                  enabled: state is DataKatalogLoading,
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
                                                  enabled: state is DataKatalogLoading,
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
                                                  enabled: state is DataKatalogLoading,
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
                                  if (state is DataKatalogLoadFailure)
                                    Positioned(
                                      bottom: 100,
                                      left: 50,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<DataKatalogBloc>(context).add(
                                                FetchDataKatalog(FilterKatalog(type: "terbaru")),
                                              );
                                            },
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(
                                                    Style.buttonBackgroundColor)),
                                            child: const Text("Coba lagi !"),
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            }

                            if (state.type.toLowerCase().contains("terbaru")) {
                              dataTerbaru = state.data.result;
                            }

                            return SizedBox(
                              height: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: dataTerbaru.length,
                                  itemBuilder: (context, index) {
                                    return Ekatalog(data: dataTerbaru[index]);
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //JudulEkatalog(judul: "New Product"),
                // BlocListener(
                //   bloc: BlocProvider.of<DataKatalogBloc>(context),
                //   listener: (context, state) {},
                //   child: BlocBuilder<DataKatalogBloc, DataKatalogState>(
                //     builder: ((context, state) {
                //       // if (state is DataKatalogLoading) {
                //       // }
                //       if (state is! DataKatalogLoadSuccess) {
                //         return Stack(
                //           children: [
                //             SizedBox(
                //               height: 250,
                //               child: Padding(
                //                 padding: const EdgeInsets.all(10),
                //                 child: ListView.builder(
                //                   scrollDirection: Axis.horizontal,
                //                   shrinkWrap: true,
                //                   itemCount: 3,
                //                   itemBuilder: (context, index) {
                //                     return Card(
                //                       elevation: 1.0,
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(16),
                //                       ),
                //                       child: Column(
                //                         children: [
                //                           Shimmer.fromColors(
                //                             enabled:
                //                                 state is DataKatalogLoading,
                //                             baseColor: Colors.white,
                //                             highlightColor: Colors.grey,
                //                             child: Container(
                //                               decoration: const BoxDecoration(
                //                                 borderRadius: BorderRadius.only(
                //                                   topLeft: Radius.circular(16),
                //                                   topRight: Radius.circular(16),
                //                                 ),
                //                                 color: Colors.white,
                //                               ),
                //                               height: 170,
                //                               width: 180,
                //                             ),
                //                           ),
                //                           const SizedBox(height: 6),
                //                           Shimmer.fromColors(
                //                             enabled:
                //                                 state is DataKatalogLoading,
                //                             baseColor: Colors.white,
                //                             highlightColor: Colors.grey,
                //                             child: Container(
                //                               decoration: const BoxDecoration(
                //                                 // borderRadius:
                //                                 //     BorderRadius.circular(16),
                //                                 color: Colors.white,
                //                               ),
                //                               height: 20,
                //                               width: 180,
                //                             ),
                //                           ),
                //                           const SizedBox(height: 6),
                //                           Shimmer.fromColors(
                //                             enabled:
                //                                 state is DataKatalogLoading,
                //                             baseColor: Colors.white,
                //                             highlightColor: Colors.grey,
                //                             child: Container(
                //                               decoration: const BoxDecoration(
                //                                 borderRadius: BorderRadius.only(
                //                                   bottomLeft:
                //                                       Radius.circular(16),
                //                                   bottomRight:
                //                                       Radius.circular(16),
                //                                 ),
                //                                 color: Colors.white,
                //                               ),
                //                               height: 20,
                //                               width: 180,
                //                             ),
                //                           )
                //                         ],
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ),
                //             ),
                //             if (state is DataKatalogLoadFailure)
                //               Positioned(
                //                 bottom: 100,
                //                 left: 50,
                //                 child: Row(
                //                   mainAxisSize: MainAxisSize.max,
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     ElevatedButton(
                //                       onPressed: () {
                //                         BlocProvider.of<DataKatalogBloc>(
                //                                 context)
                //                             .add(
                //                           FetchDataKatalog(
                //                               FilterKatalog(type: "terlaris")),
                //                         );
                //                       },
                //                       style: ButtonStyle(
                //                           backgroundColor:
                //                               MaterialStateProperty.all<Color>(
                //                                   Style.buttonBackgroundColor)),
                //                       child: const Text("Coba lagi !"),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //           ],
                //         );
                //       }
                //       // if (state is DataKatalogLoadFailure) {
                //       //   return Text('Error ${state.pesan}');
                //       // }
                //       // if (state is DataKatalogNoInternet) {
                //       //   return const NoInternetWidget();
                //       // }
                //       // return const Text('Preparing');
                //       // return Shimmer.fromColors(
                //       //   baseColor: Colors.grey[400]!,
                //       //   highlightColor: Colors.green[100]!,
                //       //   child: ,
                //       // );
                //       if (state.type.toLowerCase().contains("terlaris")) {
                //         dataTerlaris = state.data.result;
                //       }
                //       return SizedBox(
                //         height: 250,
                //         child: Padding(
                //           padding: const EdgeInsets.all(10),
                //           child: ListView.builder(
                //             scrollDirection: Axis.horizontal,
                //             shrinkWrap: true,
                //             itemCount: dataTerlaris.length,
                //             itemBuilder: (context, index) {
                //               return Ekatalog(data: dataTerlaris[index]);
                //             },
                //           ),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                AboutCard(),
                const SizedBox(height: 20),
              ],
            ),
            // BlocBuilder<DataKatalogBloc, DataKatalogState>(
            //     builder: (context, state) {
            //   }
            //   return Text("");
            // }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Products',
          ),
          /* BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Jadwal',
          ), */
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Style.buttonBackgroundColor,
        onTap: ((value) {
          if (value == 1) {
            Navigator.of(context).pushNamed(DataKatalogScreen.routeName);
            return;
          }
          if (value == 2) {
            Navigator.of(context).pushNamed(DataPemesananScreen.routeName);
            return;
          }
          if (value == 3) {
            Navigator.of(context).pushNamed(
              DataPelangganUbahScreen.routeName,
              arguments: DataPelangganUbahArguments(
                data: DataPelanggan(),
                judul: "Profile",
              ),
            );
            return;
          }
        }),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
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
}

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_hapus_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_selesai_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_simpan_bloc.dart';
import 'package:sewoapp/data_cart/bloc/data_cart_ubah_bloc.dart';
import 'package:sewoapp/data_cart/data_cart_screen.dart';
import 'package:sewoapp/data_katalog/bloc/data_katalog_bloc.dart';
import 'package:sewoapp/data_katalog/data_katalog_detail.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_bloc.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_hapus_bloc.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_simpan_bloc.dart';
import 'package:sewoapp/data_ongkir/bloc/data_ongkir_ubah_bloc.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_bloc.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_simpan_bloc.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_ubah_bloc.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_tambah.dart';
import 'package:sewoapp/data_pelanggan/data_pelanggan_ubah.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_bloc.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_hapus_bloc.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_simpan_bloc.dart';
import 'package:sewoapp/data_pemesanan/bloc/data_pemesanan_ubah_bloc.dart';
import 'package:sewoapp/data_pemesanan/data_pemesanan_screen.dart';
import 'package:sewoapp/emissions_calculator/emissions_calculator.dart';
import 'package:sewoapp/home/home_screen.dart';
import 'package:sewoapp/home/other_menu.dart';
import 'package:sewoapp/home/sewo_point_screen.dart';
import 'package:sewoapp/login/login_screen.dart';
import 'package:sewoapp/frame/frame_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sewo',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      routes: {
        HomeScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataKatalogBloc>(
                  create: (BuildContext context) => DataKatalogBloc(),
                ),
              ],
              child: const HomeScreen(),
            ),
        LoginScreen.routeName: (context) => const LoginScreen(),
        FrameScreen.routeName: (context) => const FrameScreen(),
        DataPelangganTambahScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataPelangganSimpanBloc>(
                  create: (BuildContext context) => DataPelangganSimpanBloc(),
                ),
              ],
              child: const DataPelangganTambahScreen(),
            ),
        DataPelangganUbahScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataPelangganBloc>(
                  create: (BuildContext context) => DataPelangganBloc(),
                ),
                BlocProvider<DataPelangganUbahBloc>(
                  create: (BuildContext context) => DataPelangganUbahBloc(),
                ),
              ],
              child: const DataPelangganUbahScreen(),
            ),
        DataKatalogScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataKatalogBloc>(
                  create: (BuildContext context) => DataKatalogBloc(),
                ),
                BlocProvider<DataCartBloc>(
                  create: (BuildContext context) => DataCartBloc(),
                ),
              ],
              child: const DataKatalogScreen(),
            ),
        DataKatalogDetail.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataCartBloc>(
                  create: (BuildContext context) => DataCartBloc(),
                ),
                BlocProvider<DataCartSimpanBloc>(
                  create: (BuildContext context) => DataCartSimpanBloc(),
                ),
              ],
              child: const DataKatalogDetail(),
            ),
        DataCartScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataCartBloc>(
                  create: (BuildContext context) => DataCartBloc(),
                ),
                BlocProvider<DataCartHapusBloc>(
                  create: (BuildContext context) => DataCartHapusBloc(),
                ),
                BlocProvider<DataCartUbahBloc>(
                  create: (BuildContext context) => DataCartUbahBloc(),
                ),
                BlocProvider<DataCartSimpanBloc>(
                  create: (BuildContext context) => DataCartSimpanBloc(),
                ),
                BlocProvider<DataOngkirBloc>(
                  create: (BuildContext context) => DataOngkirBloc(),
                ),
                BlocProvider<DataOngkirHapusBloc>(
                  create: (BuildContext context) => DataOngkirHapusBloc(),
                ),
                BlocProvider<DataOngkirUbahBloc>(
                  create: (BuildContext context) => DataOngkirUbahBloc(),
                ),
                BlocProvider<DataOngkirSimpanBloc>(
                  create: (BuildContext context) => DataOngkirSimpanBloc(),
                ),
                BlocProvider<DataCartSelesaiBloc>(
                  create: (BuildContext context) => DataCartSelesaiBloc(),
                ),
              ],
              child: const DataCartScreen(),
            ),
        DataPemesananScreen.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DataPemesananBloc>(
                  create: (BuildContext context) => DataPemesananBloc(),
                ),
                BlocProvider<DataPemesananHapusBloc>(
                  create: (BuildContext context) => DataPemesananHapusBloc(),
                ),
                BlocProvider<DataPemesananUbahBloc>(
                  create: (BuildContext context) => DataPemesananUbahBloc(),
                ),
                BlocProvider<DataPemesananSimpanBloc>(
                  create: (BuildContext context) => DataPemesananSimpanBloc(),
                ),
              ],
              child: const DataPemesananScreen(),
            ),
        EmissionsCalculatorPage.routeName: (context) => const  EmissionsCalculatorPage(),
        OtherMenuScreen.routeName: (context) => OtherMenuScreen(),
        SewoPointScreen.routeName: (context) => const SewoPointScreen(),
      },
      theme: ThemeData(
        primaryColor: Style.buttonBackgroundColor,
        appBarTheme: const AppBarTheme(color: Style.buttonBackgroundColor),
      ),
    );
  }
}

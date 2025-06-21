import 'package:flutter/material.dart';
import 'package:sewoapp/data_cart/data/data_cart.dart';
import 'package:sewoapp/data_cart/data_cart_screen.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/frame/frame_screen.dart';

class HomeApp extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeApp({super.key, required this.scaffoldKey});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircleMenuButton(
                      "Location",  // Use newline character
                      Icons.location_on,
                          () {
                            Navigator.of(context).pushNamed(
                              FrameScreen.routeName,
                              arguments: 'https://localhost.scode.web.id/2025-sewo/location.php', // URL tujuan
                            );
                      },
                    ),
                    _buildCircleMenuButton("SeMotor", Icons.two_wheeler, () {
                      _navigateToKatalog('SeMotor', 'SeMotor');
                    }),
                    _buildCircleMenuButton("SeMobil", Icons.directions_car, () {
                      _navigateToKatalog('SeMobil', 'SeMobil');
                    }),
                    _buildCircleMenuButton("SeMolis", Icons.moped, () {
                      _navigateToKatalog('SeMolis', 'SeMolis');
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  Widget _buildCircleMenuButton(String text, IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
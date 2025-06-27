import 'package:flutter/material.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/emissions_calculator/emissions_calculator.dart';
import 'package:sewoapp/frame/frame_screen.dart';
import '../config/config_global.dart';

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
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 4,
                  runSpacing: 6,
                  children: [
                    _buildCircleMenuButton(
                      "Location",  // Use newline character
                      Icons.location_on,
                          () {
                            Navigator.of(context).pushNamed(
                              FrameScreen.routeName,
                              arguments: '${ConfigGlobal.baseUrl}map.php', // URL tujuan
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
                    _buildCircleMenuButton("Emissions", Icons.eco, () {
                      Navigator.of(context).pushNamed(EmissionsCalculatorPage.routeName);
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
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 25,
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
    );
  }
}
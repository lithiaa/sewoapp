import 'package:flutter/material.dart';
import 'package:sewoapp/home/sewo_point_screen.dart';

import '../config/config_global.dart';
import '../data_katalog/data_katalog_screen.dart';
import '../emissions_calculator/emissions_calculator.dart';
import '../frame/frame_screen.dart';

class OtherMenuScreen extends StatelessWidget {
  static const routeName = '/other_menu';

  final List<_MenuItem> menuItems = const [
    _MenuItem('SeMotor', 'assets/ikon_semotor.png'),
    _MenuItem('SeMobil', 'assets/ikon_semobil.png'),
    _MenuItem('SeMolis', 'assets/ikon_semolis.png'),
    _MenuItem('Emission Calculator', 'assets/ikon_emisi.png'),
    _MenuItem('SewoPoint', 'assets/ikon_sewopoint.png'),
    _MenuItem('Maps', 'assets/ikon_maps.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Menu'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: () {
                switch (item.title) {
                  case 'SeMotor':
                    _navigateToKatalog(context, 'SeMotor', 'SeMotor');
                    break;
                  case 'SeMobil':
                    _navigateToKatalog(context, 'SeMobil', 'SeMobil');
                    break;
                  case 'SeMolis':
                    _navigateToKatalog(context, 'SeMolis', 'SeMolis');
                    break;
                  case 'Emission Calculator':
                    Navigator.of(context).pushNamed(EmissionsCalculatorPage.routeName);
                    break;
                  case 'SewoPoint':
                    Navigator.of(context).pushNamed(SewoPointScreen.routeName);
                    break;
                  case 'Maps':
                    Navigator.of(context).pushNamed(
                      FrameScreen.routeName,
                      arguments: '${ConfigGlobal.baseUrl}map.php',
                    );
                    break;
                }switch (item.title) {
                  case 'SeMotor':
                    _navigateToKatalog(context, 'SeMotor', 'SeMotor');
                    break;
                  case 'Semobil':
                    _navigateToKatalog(context, 'SeMobil', 'SeMobil');
                    break;
                  case 'Semolis':
                    _navigateToKatalog(context, 'SeMolis', 'SeMolis');
                    break;
                  case 'Emissions Calculator':
                    Navigator.of(context).pushNamed(EmissionsCalculatorPage.routeName);
                    break;
                  case 'SewoPoint':
                    Navigator.of(context).pushNamed(SewoPointScreen.routeName);
                    break;
                  case 'Maps':switch (item.title) {
                    case 'SeMotor':
                      _navigateToKatalog(context, 'SeMotor', 'SeMotor');
                      break;
                    case 'SeMobil':
                      _navigateToKatalog(context, 'SeMobil', 'SeMobil');
                      break;
                    case 'SeMolis':
                      _navigateToKatalog(context, 'SeMolis', 'SeMolis');
                      break;
                    case 'Emission Calculator':
                      Navigator.of(context).pushNamed(EmissionsCalculatorPage.routeName);
                      break;
                    case 'SewoPoint':
                      Navigator.of(context).pushNamed(SewoPointScreen.routeName);
                      break;
                    case 'Maps':
                      Navigator.of(context).pushNamed(
                        FrameScreen.routeName,
                        arguments: '${ConfigGlobal.baseUrl}map.php',
                      );
                      break;
                  }
                    Navigator.of(context).pushNamed(
                      FrameScreen.routeName,
                      arguments: '${ConfigGlobal.baseUrl}map.php', // URL tujuan
                    );
                    break;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4B79D1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(item.assetPath, width: 60, height: 60),
                    const SizedBox(height: 10),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToKatalog(BuildContext context, String category, String searchText) {
    Navigator.of(context).pushNamed(
      DataKatalogScreen.routeName,
      arguments: {
        'category': category,
        'searchText': searchText,
      },
    );
  }
}

class _MenuItem {
  final String title;
  final String assetPath;

  const _MenuItem(this.title, this.assetPath);
}
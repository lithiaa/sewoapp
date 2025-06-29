import 'package:flutter/material.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/emissions_calculator/emissions_calculator.dart';
import 'package:sewoapp/home/sewo_point_screen.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              color: Color.fromARGB(255, 9, 30, 94),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: _buildCircleMenuButton("SeMotor", Icons.two_wheeler, () {
                        _navigateToKatalog('SeMotor', 'SeMotor');
                      }),
                    ),
                    Flexible(
                      child: _buildCircleMenuButton("SeMobil", Icons.directions_car, () {
                        _navigateToKatalog('SeMobil', 'SeMobil');
                      }),
                    ),
                    Flexible(
                      child: _buildCircleMenuButton("SeMolis", Icons.moped, () {
                        _navigateToKatalog('SeMolis', 'SeMolis');
                      }),
                    ),
                    Flexible(
                      child: _buildCircleMenuButton("Emissions", Icons.eco, () {
                        Navigator.of(context).pushNamed(EmissionsCalculatorPage.routeName);
                      }),
                    ),
                    Flexible(
                      child: _buildCircleMenuButton("SewoPoint", Icons.star, () {
                        Navigator.of(context).pushNamed(SewoPointScreen.routeName);
                      }),
                    ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive sizing based on available width
        double screenWidth = MediaQuery.of(context).size.width;
        double buttonSize = screenWidth > 400 ? 40 : 38;
        double iconSize = screenWidth > 400 ? 18 : 16;
        double fontSize = screenWidth > 400 ? 9 : 8;
        
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(buttonSize / 2),
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
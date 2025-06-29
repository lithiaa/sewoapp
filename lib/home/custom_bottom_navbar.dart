import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/data_pemesanan/data_pemesanan_screen.dart';
import 'package:sewoapp/frame/frame_screen.dart';
import 'package:sewoapp/profil/profil_screen.dart';
import 'package:sewoapp/home/home_screen.dart';

class CustomBottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Bottom Navigation Bar
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: widget.currentIndex,
            selectedItemColor: Style.buttonBackgroundColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedFontSize: 12,
            unselectedFontSize: 11,
            iconSize: 24,
            onTap: widget.onTap,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_outlined),
                activeIcon: Icon(Icons.list),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(width: 24, height: 24), // Placeholder for floating button
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                activeIcon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          ),
        ),
        
        // Floating Action Button in the center
        Positioned(
          top: -30,
          left: MediaQuery.of(context).size.width / 2 - 32,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Style.buttonBackgroundColor,
                  Style.buttonBackgroundColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Style.buttonBackgroundColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () {
                  // Haptic feedback untuk user experience yang lebih baik
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pushNamed(
                    FrameScreen.routeName,
                    arguments: '${ConfigGlobal.baseUrl}map.php',
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Helper class untuk menangani navigasi
class BottomNavHandler {
  static void handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Home
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        break;
      case 1:
        // Products
        Navigator.of(context).pushNamed(DataKatalogScreen.routeName);
        break;
      case 2:
        // Maps - handled by FloatingActionButton
        break;
      case 3:
        // History
        Navigator.of(context).pushNamed(DataPemesananScreen.routeName);
        break;
      case 4:
        // Profile
        Navigator.of(context).pushNamed(ProfilScreen.routeName);
        break;
    }
  }
}

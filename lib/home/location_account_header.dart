import 'package:flutter/material.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
import 'package:sewoapp/login/login_screen.dart';
import 'package:sewoapp/config/color.dart';

class LocationAccountHeader extends StatefulWidget {
  const LocationAccountHeader({super.key});

  @override
  State<LocationAccountHeader> createState() => LocationAccountHeaderState();
}

class LocationAccountHeaderState extends State<LocationAccountHeader> {
  LoginApiData? userData;
  bool isLoggedIn = false;
  String currentLocation = 'Jakarta, DKI Jakarta'; // Default location

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Method public untuk memperbarui status login dari luar
  void refreshLoginStatus() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final session = ConfigSessionManager.getInstance();
      final sudahLogin = await session.sudahLogin();
      if (sudahLogin) {
        final data = await session.getData();
        if (mounted) {
          setState(() {
            isLoggedIn = true;
            userData = data;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isLoggedIn = false;
            userData = null;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoggedIn = false;
          userData = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian kiri - Lokasi
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Location',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        currentLocation,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Bagian kanan - Akun/Login
          Expanded(
            flex: 2,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: animation.drive(
                    Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                  ),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: isLoggedIn && userData != null 
                ? _buildUserInfo() 
                : _buildLoginButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      key: const ValueKey('user_info'),
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Hello,',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                _getDisplayName(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Column(
      key: const ValueKey('login_button'),
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(LoginScreen.routeName).then((_) {
              // Refresh status login setelah kembali dari halaman login
              _checkLoginStatus();
            });
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Style.buttonBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  'Login/Signup',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getDisplayName() {
    if (userData?.namaPegawai != null && userData!.namaPegawai!.isNotEmpty) {
      return userData!.namaPegawai!;
    }
    return 'User';
  }
}

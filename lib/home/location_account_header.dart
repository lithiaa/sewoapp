import 'package:flutter/material.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
import 'package:sewoapp/login/login_screen.dart';
import 'package:sewoapp/config/color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationAccountHeader extends StatefulWidget {
  const LocationAccountHeader({super.key});

  @override
  State<LocationAccountHeader> createState() => LocationAccountHeaderState();
}

class LocationAccountHeaderState extends State<LocationAccountHeader> {
  LoginApiData? userData;
  bool isLoggedIn = false;
  String currentLocation = 'Getting location...'; // Default while loading
  bool isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _getCurrentLocation();
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

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() {
            currentLocation = 'Jakarta, DKI Jakarta'; // Fallback
            isLoadingLocation = false;
          });
        }
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            setState(() {
              currentLocation = 'Jakarta, DKI Jakarta'; // Fallback
              isLoadingLocation = false;
            });
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() {
            currentLocation = 'Jakarta, DKI Jakarta'; // Fallback
            isLoadingLocation = false;
          });
        }
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );

      // Get location name from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String locationName = '';
        
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          locationName = place.subLocality!;
        } else if (place.locality != null && place.locality!.isNotEmpty) {
          locationName = place.locality!;
        } else if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
          locationName = place.subAdministrativeArea!;
        }

        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          locationName += locationName.isNotEmpty 
              ? ', ${place.administrativeArea}' 
              : place.administrativeArea!;
        }

        if (mounted) {
          setState(() {
            currentLocation = locationName.isNotEmpty ? locationName : 'Unknown Location';
            isLoadingLocation = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            currentLocation = 'Location detected';
            isLoadingLocation = false;
          });
        }
      }
    } catch (e) {
      print('Error getting location: $e');
      if (mounted) {
        setState(() {
          currentLocation = 'Jakarta, DKI Jakarta'; // Fallback to default
          isLoadingLocation = false;
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
                    if (isLoadingLocation)
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(right: 6),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLoadingLocation = true;
                            currentLocation = 'Getting location...';
                          });
                          _getCurrentLocation();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
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

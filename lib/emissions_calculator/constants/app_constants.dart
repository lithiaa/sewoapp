import 'package:flutter/material.dart';

/// Konstanta untuk UI dan teks aplikasi emissions calculator
class EmissionsConstants {
  // Colors
  static const Color backgroundColor = Color(0xFFEAF1FB);
  static const Color cardColor = Colors.white;
  static const Color primaryGreen = Colors.green;
  static const Color dangerRed = Colors.red;
  static const Color textPrimary = Colors.black;
  
  // Text Styles
  static const TextStyle boldText = TextStyle(fontWeight: FontWeight.bold);
  static const TextStyle titleText = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  static const TextStyle routeText = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle italicText = TextStyle(fontStyle: FontStyle.italic);
  
  // UI Constants
  static const double defaultPadding = 20.0;
  static const double cardPadding = 16.0;
  static const double borderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const double logoHeight = 30.0;
  static const double iconSize = 50.0;
  static const double cardOpacity = 0.8;
  static const double resultCardOpacity = 0.9;
  static const double donationCardOpacity = 0.95;
  
  // Text Messages
  static const String appTitle = 'Emissions Offsetting';
  static const String fromCityLabel = 'From City';
  static const String toCityLabel = 'To City';
  static const String vehicleTypeLabel = 'Vehicle Type';
  static const String calculateButtonText = 'Calculate Carbon Footprint';
  static const String resultTitle = 'My Carbon Footprint Result';
  static const String emissionsText = 'emissions created by my trip';
  static const String donationQuestion = 'Want to offset these emissions by planting trees?';
  static const String donateButtonText = "Yes, I'll donate Rp5.000 to plant 2 tree";
  static const String declineButtonText = 'No thanks';
  static const String thankYouMessage = 'Thanks for donating!';
  static const String sameCityError = 'Please select different cities for origin and destination!';
  static const String routeNotAvailableError = 'Route not available!';
  static const String motivationalQuote = 
      '"Every trip can be more meaningful. Calculate your carbon footprint and make a real contribution to the environment."';
  
  // Assets
  static const String logoAsset = 'assets/logo.png';
}

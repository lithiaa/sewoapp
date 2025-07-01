import '../data/city_distances_data.dart';
import '../data/emission_factors_data.dart';

/// Utility class untuk kalkulasi emisi karbon
class EmissionCalculator {
  /// Menghitung emisi karbon berdasarkan jarak dan jenis kendaraan
  static double? calculateEmission({
    required String fromCity,
    required String toCity,
    required String vehicleType,
  }) {
    // Cek apakah kota asal dan tujuan sama
    if (fromCity == toCity) {
      return null;
    }

    // Dapatkan jarak antar kota
    int? distance = CityDistancesData.cityDistances[fromCity]?[toCity];
    if (distance == null) {
      return null;
    }

    // Dapatkan faktor emisi
    double? emissionFactor = EmissionFactorsData.emissionFactors[vehicleType];
    if (emissionFactor == null) {
      return null;
    }

    // Hitung emisi
    return distance * emissionFactor;
  }

  /// Menghitung jumlah pohon yang dibutuhkan untuk offset emisi
  static int calculateTreesNeeded(double emission) {
    return (emission / EmissionFactorsData.treeAbsorptionFactor).ceil();
  }

  /// Mendapatkan jarak antar dua kota
  static int? getDistance(String fromCity, String toCity) {
    return CityDistancesData.cityDistances[fromCity]?[toCity];
  }

  /// Mendapatkan deskripsi kendaraan
  static String getVehicleDescription(String vehicleType) {
    return EmissionFactorsData.vehicleDescriptions[vehicleType] ?? vehicleType;
  }
}

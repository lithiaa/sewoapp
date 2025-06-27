/// Data faktor emisi untuk berbagai jenis kendaraan
/// Satuan: kg CO₂ per kilometer
class EmissionFactorsData {
  static const Map<String, double> emissionFactors = {
    'Motorcycle': 0.092,  // Motor
    'Car': 0.192,         // Mobil
    'Electric': 0.04,     // Kendaraan listrik
  };

  /// Mendapatkan deskripsi untuk setiap jenis kendaraan
  static const Map<String, String> vehicleDescriptions = {
    'Motorcycle': 'Sepeda Motor',
    'Car': 'Mobil Bensin/Diesel',
    'Electric': 'Kendaraan Listrik',
  };

  /// Faktor konversi untuk menghitung jumlah pohon yang dibutuhkan
  /// 1 pohon dapat menyerap sekitar 1.8 kg CO₂ per tahun
  static const double treeAbsorptionFactor = 1.8;
}

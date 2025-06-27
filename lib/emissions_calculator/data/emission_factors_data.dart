/// Data faktor emisi untuk berbagai jenis kendaraan
/// Satuan: kg CO₂ per kilometer
class EmissionFactorsData {
  static const Map<String, double> emissionFactors = {
    'Motorcycle': 0.092,           // Motor bensin
    'Car': 0.192,                  // Mobil bensin/diesel
    'Electric Motorcycle': 0.025,  // Motor listrik
    'Electric Car': 0.04,          // Mobil listrik
  };

  /// Mendapatkan deskripsi untuk setiap jenis kendaraan
  static const Map<String, String> vehicleDescriptions = {
    'Motorcycle': 'Motorcycle',
    'Car': 'Car',
    'Electric Motorcycle': 'Electric Motorcycle',
    'Electric Car': 'Electric Car',
  };

  /// Faktor konversi untuk menghitung jumlah pohon yang dibutuhkan
  /// 1 pohon dapat menyerap sekitar 1.8 kg CO₂ per tahun
  static const double treeAbsorptionFactor = 1.8;
}

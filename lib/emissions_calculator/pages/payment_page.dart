import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';
import '../utils/emission_calculator.dart';

class PaymentPage extends StatefulWidget {
  final double emissionResult;
  final String fromCity;
  final String toCity;
  final String vehicleType;

  const PaymentPage({
    Key? key,
    required this.emissionResult,
    required this.fromCity,
    required this.toCity,
    required this.vehicleType,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _donationController = TextEditingController();
  double suggestedDonation = 0;

  @override
  void initState() {
    super.initState();
    // Hitung donasi yang disarankan berdasarkan emisi (misalnya Rp 2000 per kg CO₂)
    suggestedDonation = widget.emissionResult * 2000;
    _donationController.text = suggestedDonation.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _donationController.dispose();
    super.dispose();
  }

  void _completeDonation() {
    double donationAmount = double.tryParse(_donationController.text) ?? 0;
    
    if (donationAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid donation amount!")),
      );
      return;
    }

    // Tampilkan dialog konfirmasi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thank You!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text(
                "Your donation of Rp ${donationAmount.toStringAsFixed(0)} has been received!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "You have contributed to a better environment.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int treesNeeded = EmissionCalculator.calculateTreesNeeded(widget.emissionResult);
    
    return Scaffold(
      backgroundColor: EmissionsConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: EmissionsConstants.textPrimary,
        title: Text('Carbon Offset Payment', style: EmissionsConstants.boldText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(EmissionsConstants.defaultPadding),
        child: Column(
          children: [
            // Carbon Footprint Summary Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text("Your Carbon Footprint", 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Route:", style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("${widget.fromCity} → ${widget.toCity}"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Distance:", style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("${EmissionCalculator.getDistance(widget.fromCity, widget.toCity)} km"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Vehicle:", style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(EmissionCalculator.getVehicleDescription(widget.vehicleType)),
                    ],
                  ),
                  Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CO₂ Emissions:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${widget.emissionResult.toStringAsFixed(2)} kg", 
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trees to Plant:", style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("$treesNeeded tree(s)", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Donation Amount Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Donation Amount", 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 16),
                  Text("Suggested donation: Rp ${suggestedDonation.toStringAsFixed(0)}", 
                      style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 12),
                  Text("Enter your donation amount:", 
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: _donationController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      prefixText: "Rp ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Enter donation amount",
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Quick Amount Buttons
                  Text("Quick Amount:", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildQuickAmountButton(5000),
                      _buildQuickAmountButton(10000),
                      _buildQuickAmountButton(25000),
                      _buildQuickAmountButton(50000),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // QRIS Payment Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text("Scan QRIS to Donate", 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/qris.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.qr_code, size: 80, color: Colors.grey[400]),
                                SizedBox(height: 8),
                                Text("QRIS Code", style: TextStyle(color: Colors.grey[600])),
                                Text("(Image not found)", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Scan the QR code above with your e-wallet app to complete the donation",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Donation Complete Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _completeDonation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF11316C),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "I Have Donated",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 16),

            Text(
              "Your donation will help plant trees and support environmental projects to offset your carbon footprint.",
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(int amount) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _donationController.text = amount.toString();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black87,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text("${amount ~/ 1000}K"),
    );
  }
}

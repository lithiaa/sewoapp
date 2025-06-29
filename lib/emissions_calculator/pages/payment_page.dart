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
  String selectedPaymentMethod = 'QRIS';

  final Map<String, Map<String, String>> paymentMethods = {
    'QRIS': {
      'title': 'QRIS',
      'subtitle': 'Scan QR Code',
      'icon': 'qr_code',
    },
    'Bank Transfer': {
      'title': 'Bank Transfer',
      'subtitle': 'Transfer to Bank Account',
      'icon': 'account_balance',
    },
    'E-Wallet': {
      'title': 'E-Wallet',
      'subtitle': 'GoPay, OVO, DANA',
      'icon': 'wallet',
    },
  };

  final Map<String, Map<String, String>> paymentDetails = {
    'QRIS': {
      'type': 'qr',
      'image': 'assets/qris.png',
      'instruction': 'Scan the QR code above with your e-wallet app to complete the donation',
    },
    'Bank Transfer': {
      'type': 'bank',
      'bank_name': 'Bank Central Asia (BCA)',
      'account_number': '1234567890',
      'account_name': 'YAYASAN CARBON OFFSET INDONESIA',
      'instruction': 'Transfer to the bank account above and keep the receipt as proof of payment',
    },
    'E-Wallet': {
      'type': 'ewallet',
      'gopay': '081234567890',
      'ovo': '081234567891',
      'dana': '081234567892',
      'instruction': 'Transfer to one of the e-wallet numbers above',
    },
  };

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
        title: const Text(
          'Carbon Offset Payment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: EmissionsConstants.backgroundColor,
        foregroundColor: EmissionsConstants.textPrimary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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

            // Payment Method Selection Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Method", 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 16),
                  ...paymentMethods.entries.map((entry) => 
                    _buildPaymentMethodOption(entry.key, entry.value)
                  ).toList(),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Payment Details Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildPaymentDetails(),
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

  Widget _buildPaymentMethodOption(String method, Map<String, String> details) {
    IconData iconData;
    switch (details['icon']) {
      case 'qr_code':
        iconData = Icons.qr_code;
        break;
      case 'account_balance':
        iconData = Icons.account_balance;
        break;
      case 'wallet':
        iconData = Icons.account_balance_wallet;
        break;
      default:
        iconData = Icons.payment;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPaymentMethod == method 
                ? Color(0xFF11316C) 
                : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selectedPaymentMethod == method 
              ? Color(0xFF11316C).withOpacity(0.1) 
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: selectedPaymentMethod == method 
                  ? Color(0xFF11316C) 
                  : Colors.grey[600],
              size: 24,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selectedPaymentMethod == method 
                          ? Color(0xFF11316C) 
                          : Colors.black87,
                    ),
                  ),
                  Text(
                    details['subtitle']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (selectedPaymentMethod == method)
              Icon(
                Icons.check_circle,
                color: Color(0xFF11316C),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    final details = paymentDetails[selectedPaymentMethod]!;
    
    switch (details['type']) {
      case 'qr':
        return _buildQRISDetails(details);
      case 'bank':
        return _buildBankDetails(details);
      case 'ewallet':
        return _buildEWalletDetails(details);
      default:
        return Container();
    }
  }

  Widget _buildQRISDetails(Map<String, String> details) {
    return Column(
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
              details['image']!,
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
          details['instruction']!,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildBankDetails(Map<String, String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bank Transfer Details", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 16),
        _buildDetailRow("Bank", details['bank_name']!),
        SizedBox(height: 8),
        _buildDetailRow("Account Number", details['account_number']!),
        SizedBox(height: 8),
        _buildDetailRow("Account Name", details['account_name']!),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue[600], size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  details['instruction']!,
                  style: TextStyle(color: Colors.blue[800], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEWalletDetails(Map<String, String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("E-Wallet Details", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 16),
        _buildDetailRow("GoPay", details['gopay']!),
        SizedBox(height: 8),
        _buildDetailRow("OVO", details['ovo']!),
        SizedBox(height: 8),
        _buildDetailRow("DANA", details['dana']!),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.green[600], size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  details['instruction']!,
                  style: TextStyle(color: Colors.green[800], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label + ":", style: TextStyle(fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$label copied to clipboard!")),
            );
          },
          child: Icon(Icons.copy, size: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

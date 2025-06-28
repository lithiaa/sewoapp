import 'package:flutter/material.dart';

class SewoPointScreen extends StatelessWidget {
  static const routeName = '/sewopoint';

  const SewoPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF1FB),
      appBar: AppBar(
        title: Text('Sewo Points'),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Point Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text("SILVER", style: TextStyle(fontSize: 10, color: Colors.white)),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Silver", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("2,150 Points", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 2150 / 3000,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("2.150 / 3.000", style: TextStyle(fontSize: 12)),
                  )
                ],
              ),
            ),
            SizedBox(height: 24),
            Text("Level up Requirements", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("• Earn at least 3,000 points through orders or donations"),
            Text("• Complete a minimum of 500 orders within the app"),
            Text("• Spend a total of at least IDR 20,000,000,- during the specified period"),
            Text("• Invite friends to join and earn extra points when they order or donate"),
            SizedBox(height: 24),
            Row(
              children: [
                _promoBox("20%", "with no min. spend"),
                SizedBox(width: 12),
                _promoBox("30%", "on orders over Rp500,000"),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/katalog', arguments: {
                    'category': 'SeMobil',
                    'searchText': 'SeMobil',
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B79D1),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text("LEVEL UP NOW", style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _promoBox(String discount, String subtitle) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF4B79D1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(discount, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("OFF", style: TextStyle(color: Colors.white, fontSize: 12)),
            SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

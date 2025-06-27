import 'package:flutter/material.dart';

class EmissionsCalculatorPage extends StatefulWidget {
  static const routeName = '/emissions';

  const EmissionsCalculatorPage({super.key});

  @override
  _EmissionsCalculatorPageState createState() => _EmissionsCalculatorPageState();
}

class _EmissionsCalculatorPageState extends State<EmissionsCalculatorPage> {
  String selectedRoute = 'Yogyakarta - Borobudur';
  String selectedVehicle = 'Motorcycle';

  double? emissionResult;

  final Map<String, int> distances = {
    'Yogyakarta - Borobudur': 40,
    'Jakarta - Bandung': 150,
    'Denpasar - Ubud': 25,
  };

  final Map<String, double> emissionFactors = {
    'Motorcycle': 0.092,
    'Car': 0.192,
    'Electric': 0.04,
  };

  void calculateEmission() {
    int distance = distances[selectedRoute]!;
    double factor = emissionFactors[selectedVehicle]!;
    setState(() {
      emissionResult = (distance * factor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF1FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('Emissions Calculator', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/logo.png', height: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Input Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text("Distance", style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedRoute,
                    isExpanded: true,
                    items: distances.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text("$value = ${distances[value]} KM"),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedRoute = val!),
                  ),
                  SizedBox(height: 12),
                  Text("Vehicle Type", style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedVehicle,
                    isExpanded: true,
                    items: emissionFactors.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedVehicle = val!),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: calculateEmission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Calculate Carbon Footprint"),
                  ),
                ],
              ),
            ),

            if (emissionResult != null) ...[
              SizedBox(height: 20),
              // Result Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text("My Carbon Footprint Result", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Icon(Icons.cloud, size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("${emissionResult!.toStringAsFixed(2)} kg of CO₂",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    Text("emissions created by my trip"),
                    SizedBox(height: 8),
                    Text("Offsetting this equals to planting ${(emissionResult! / 1.8).ceil()} tree(s)."),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Donation Option
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "Want to offset these emissions by planting trees?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thanks for donating!")));
                      },
                      icon: Icon(Icons.eco),
                      label: Text("Yes, I’ll donate Rp5.000 to plant 2 tree"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: Text("No thanks"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "“Every trip can be more meaningful. Calculate your carbon footprint and make a real contribution to the environment.”",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

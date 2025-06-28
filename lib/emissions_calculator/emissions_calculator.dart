import 'package:flutter/material.dart';
import 'data/cities_data.dart';
import 'data/emission_factors_data.dart';
import 'utils/emission_calculator.dart';
import 'constants/app_constants.dart';
import 'pages/payment_page.dart';

class EmissionsCalculatorPage extends StatefulWidget {
  static const routeName = '/emissions';

  const EmissionsCalculatorPage({super.key});

  @override
  _EmissionsCalculatorPageState createState() => _EmissionsCalculatorPageState();
}

class _EmissionsCalculatorPageState extends State<EmissionsCalculatorPage> {
  String selectedFromCity = 'Jakarta';
  String selectedToCity = 'Bandung';
  String selectedVehicle = 'Motorcycle';

  double? emissionResult;

  void calculateEmission() {
    if (selectedFromCity == selectedToCity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(EmissionsConstants.sameCityError)),
      );
      return;
    }
    
    double? emission = EmissionCalculator.calculateEmission(
      fromCity: selectedFromCity,
      toCity: selectedToCity,
      vehicleType: selectedVehicle,
    );
    
    if (emission == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(EmissionsConstants.routeNotAvailableError)),
      );
      return;
    }
    
    setState(() {
      emissionResult = emission;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmissionsConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: EmissionsConstants.textPrimary,
        title: Text(EmissionsConstants.appTitle, style: EmissionsConstants.boldText),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            // child: Image.asset(EmissionsConstants.logoAsset, height: EmissionsConstants.logoHeight),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(EmissionsConstants.defaultPadding),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("From City", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DropdownButton<String>(
                    value: selectedFromCity,
                    isExpanded: true,
                    items: CitiesData.cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedFromCity = val!),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("To City", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DropdownButton<String>(
                    value: selectedToCity,
                    isExpanded: true,
                    items: CitiesData.cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedToCity = val!),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Vehicle Type", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DropdownButton<String>(
                    value: selectedVehicle,
                    isExpanded: true,
                    items: EmissionFactorsData.emissionFactors.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(EmissionCalculator.getVehicleDescription(value)),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedVehicle = val!),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: calculateEmission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF11316C),
                      foregroundColor: Colors.white,
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
                    SizedBox(height: 8),
                    Text("Route: $selectedFromCity → $selectedToCity", 
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    Text("Distance: ${EmissionCalculator.getDistance(selectedFromCity, selectedToCity)} km", 
                        style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    SizedBox(height: 16),
                    Icon(Icons.cloud, size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("${emissionResult!.toStringAsFixed(2)} kg of CO₂",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    Text("emissions created by my trip"),
                    SizedBox(height: 8),
                    Text("Offsetting this equals to planting ${EmissionCalculator.calculateTreesNeeded(emissionResult!)} tree(s)."),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              emissionResult: emissionResult!,
                              fromCity: selectedFromCity,
                              toCity: selectedToCity,
                              vehicleType: selectedVehicle,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.eco),
                      label: Text("Offset My Carbon Footprint"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF11316C),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
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

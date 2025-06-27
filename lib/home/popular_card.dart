import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularTourism extends StatefulWidget {
  final Function(String, String) onDestinationTap;

  const PopularTourism({super.key, required this.onDestinationTap});

  @override
  _PopularTourismState createState() => _PopularTourismState();
}

class _PopularTourismState extends State<PopularTourism> {
  List<Map<String, String>> destinations = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPopularDestinations();
  }

  Future<void> fetchPopularDestinations() async {
    try {
      final response = await http.get(
        Uri.parse('https://localhost.scode.web.id/2025-sewo/popular.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          destinations = List<Map<String, String>>.from(data.map((item) {
            return {
              'name': item['name'] as String,
              'image': item['image'] as String,
              'code': item['code'] as String, // Added code field
            };
          }));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.4;
    final cardPadding = screenWidth * 0.02;

    if (isLoading) {
      return SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return SizedBox(
        height: 100,
        child: Center(child: Text(errorMessage)),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: cardPadding),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => widget.onDestinationTap(
              destinations[index]['code']!,
              "AREA ${destinations[index]['name']!}",
            ),
            child: Container(
              width: cardWidth,
              margin: EdgeInsets.only(right: cardPadding),
              child: TourismCard(
                name: destinations[index]['name']!,
                imagePath: destinations[index]['image']!,
              ),
            ),
          );
        },
      ),
    );
  }
}

class TourismCard extends StatelessWidget {
  final String name;
  final String imagePath;

  const TourismCard({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.network(
            imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: Icon(Icons.broken_image),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                stops: [0.0, 0.3],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
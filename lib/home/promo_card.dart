import 'package:flutter/material.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';

class PromoCard extends StatelessWidget {
  final String category;
  final String searchText;

  const PromoCard({
    super.key,
    required this.category,
    this.searchText = '',
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    
    // Responsive values
    double containerMarginVertical = isTablet ? 10 : 6;
    double containerMarginHorizontal = isTablet ? 16 : 10;
    double borderRadius = isTablet ? 20 : 15;
    double containerPadding = isTablet ? 20 : 12;
    
    double iconWidth = isTablet ? 40 : 25;
    double iconHeight = isTablet ? 60 : 40;
    double iconSize = isTablet ? 40 : 28;
    
    double titleFontSize = isTablet ? 24 : 16;
    double descriptionFontSize = isTablet ? 14 : 10;
    double spacingBetweenTexts = isTablet ? 8 : 4;
    double horizontalSpacing = isTablet ? 20 : 12;
    
    double buttonWidth = isTablet ? 120 : 80;
    double buttonPadding = isTablet ? 12 : 8;
    double buttonBorderRadius = isTablet ? 12 : 8;
    double buttonFontSize = isTablet ? 14 : 10;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: containerMarginHorizontal, 
        vertical: containerMarginVertical
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: const Color(0xFFFFE868), // Yellow background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: isTablet ? 8 : 4,
            offset: Offset(0, isTablet ? 4 : 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(containerPadding),
        child: Row(
          children: [
            // Column 1: Moped Icon
            SizedBox(
              width: iconWidth,
              height: iconHeight,
              child: Icon(
                Icons.moped,
                size: iconSize,
                color: Colors.black,
              ),
            ),

            SizedBox(width: horizontalSpacing),

            // Column 2: Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SeMolis",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: spacingBetweenTexts),
                  Text(
                    '"Use an electric motor, more environmentally friendly!"',
                    style: TextStyle(
                      fontSize: descriptionFontSize,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: horizontalSpacing),

            // Column 3: Rent Now Button
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    DataKatalogScreen.routeName,
                    arguments: {
                      'category': category,
                      'searchText': searchText,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Color(0xFF11316C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonPadding, 
                    vertical: buttonPadding
                  ),
                ),
                child: Text(
                  "RENT NOW !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: buttonFontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';
import 'package:sewoapp/emissions_calculator/emissions_calculator.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  void _navigateToEmissionCalculator() {
    Navigator.of(context).pushNamed(EmissionsCalculatorPage.routeName);
  }

  final List<_SliderItemModel> _sliderItems = const [
    _SliderItemModel("assets/promotion_slide/slide_1.png", 'products'),
    _SliderItemModel("assets/promotion_slide/slide_2.png", 'emission_calculator'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              SizedBox(
                height: 180.0,
                child: CarouselSlider(
                  viewportFraction: 1.0,
                  enableAutoSlider: true,
                  autoSliderDelay: const Duration(milliseconds: 3000),
                  autoSliderTransitionTime: const Duration(milliseconds: 800),
                  slideTransform: DefaultTransform(),
                  unlimitedMode: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  onSlideChanged: (index) {
                    setState(() {
                      _currentIndex = index % _sliderItems.length;
                    });
                  },
                  children: _sliderItems.asMap().entries.map((entry) {
                    final item = entry.value;
                    return _SliderItem(
                      item: item,
                      onTap: () {
                        if (item.navigationType == 'products') {
                          Navigator.of(context).pushNamed(DataKatalogScreen.routeName);
                        } else if (item.navigationType == 'emission_calculator') {
                          _navigateToEmissionCalculator();
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _sliderItems.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(
                          (_currentIndex % _sliderItems.length) == entry.key ? 0.9 : 0.4,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _SliderItem extends StatelessWidget {
  final _SliderItemModel item;
  final VoidCallback? onTap;

  const _SliderItem({
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Jika ingin efek ripple, bisa ganti GestureDetector ke InkWell + Material
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            item.assetPath,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 30,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Image not found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SliderItemModel {
  final String assetPath;
  final String navigationType;
  const _SliderItemModel(this.assetPath, this.navigationType);
}

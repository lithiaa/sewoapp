import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({Key? key}) : super(key: key);

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  void _navigateToKatalog(String category, String searchText) {
    Navigator.of(context).pushNamed(
      DataKatalogScreen.routeName,
      arguments: {
        'category': category,
        'searchText': searchText,
      },
    );
  }

  final List<_SliderItemModel> _sliderItems = const [
    _SliderItemModel("assets/slide_1.png"),
    _SliderItemModel("assets/slide_2.png"),
    _SliderItemModel("assets/slide_3.png"),
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
              CarouselSlider(
                options: CarouselOptions(
                  height: 130.0,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: _sliderItems.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return Builder(builder: (BuildContext context) {
                    return _SliderItem(
                      item: item,
                      onTap: () => _navigateToKatalog('Promo', 'Promo ${idx + 1}'),
                    );
                  });
                }).toList(),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: _sliderItems.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(
                          _currentIndex == entry.key ? 0.9 : 0.4,
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
          ),
        ),
      ),
    );
  }
}

class _SliderItemModel {
  final String assetPath;
  const _SliderItemModel(this.assetPath);
}

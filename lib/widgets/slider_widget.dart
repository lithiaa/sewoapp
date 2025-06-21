import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final SliderWidgetModel card;

  SliderWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          10,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Image.asset(
            card.assetName,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class SliderWidgetModel {
  final String assetName;
  SliderWidgetModel(this.assetName);
}

List<SliderWidgetModel> getSliderWidgets() {
  List<SliderWidgetModel> creditCards = [
    SliderWidgetModel("assets/slide_1.png"),
    SliderWidgetModel("assets/slide_2.png"),
    SliderWidgetModel("assets/slide_3.png"),
  ];
  return creditCards;
}

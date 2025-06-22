import 'package:flutter/material.dart';

class EnumWidget extends StatelessWidget {
  List<String> items;
  Function(String) onChange;

  EnumWidget({
    super.key,
    required this.items,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              onChange(items[index]);
            },
          );
        },
      ),
    );
  }
}

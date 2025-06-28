import 'package:flutter/material.dart';
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';

class Pencarian extends StatefulWidget {
  const Pencarian({super.key});

  @override
  State<Pencarian> createState() => _PencarianState();
}

class _PencarianState extends State<Pencarian> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: TextFormField(
        onTap: () {
          Navigator.of(context).pushNamed(DataKatalogScreen.routeName);
        },
        readOnly: true,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search_rounded),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.white)),
          hintText: 'Search',
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 20.0,
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}

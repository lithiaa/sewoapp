import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({super.key})
      : super(
          elevation: 0.0,
          centerTitle: true,
          title: Image.asset(
            "assets/logo.png",
            width: 80,
            height: 40,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
              color: const Color(0xFF323232),
            ),
          ],
        );
}

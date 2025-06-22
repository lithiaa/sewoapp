import 'package:flutter/material.dart';

class TombolTambahWidget extends StatefulWidget {
  final VoidCallback onPress;
  const TombolTambahWidget({super.key, required this.onPress});

  @override
  State<TombolTambahWidget> createState() => _TombolTambahWidgetState();
}

class _TombolTambahWidgetState extends State<TombolTambahWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [Icon(Icons.add), Text("Tambah")],
      ),
    );
  }
}

class TombolRefreshWidget extends StatefulWidget {
  final VoidCallback onPress;
  const TombolRefreshWidget({super.key, required this.onPress});

  @override
  State<TombolRefreshWidget> createState() => _TombolRefreshWidgetState();
}

class _TombolRefreshWidgetState extends State<TombolRefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [Icon(Icons.refresh), Text("Refresh")],
      ),
    );
  }
}

class TombolCariWidget extends StatefulWidget {
  final VoidCallback onPress;
  const TombolCariWidget({super.key, required this.onPress});

  @override
  State<TombolCariWidget> createState() => _TombolCariWidgetState();
}

class _TombolCariWidgetState extends State<TombolCariWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [Icon(Icons.search), Text("Cari")],
      ),
    );
  }
}

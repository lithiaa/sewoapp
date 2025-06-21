import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FrameScreen extends StatefulWidget {
  static const routeName = "frame";

  const FrameScreen({Key? key}) : super(key: key);

  @override
  State<FrameScreen> createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  late final WebViewController _controller;
  late final String url;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    url = ModalRoute.of(context)!.settings.arguments as String;
    debugPrint("FRAME URL :: $url");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            if (url.contains('google.com/maps')) {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
              Navigator.of(context).pop();
            }
          },
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tidak bisa terhubung'),
                backgroundColor: Colors.redAccent,
              ),
            );
            Navigator.of(context).pop();
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      backgroundColor: const Color(0xFF11316C),
      appBar: AppBar(
        title: const Text("Maps"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

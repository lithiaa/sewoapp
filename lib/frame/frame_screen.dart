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
      ..setUserAgent('Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36')
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            debugPrint("Page started loading: $url");
            if (url.contains('google.com/maps')) {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
              Navigator.of(context).pop();
            }
          },
          onPageFinished: (String url) {
            debugPrint("Page finished loading: $url");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("WebView Error: ${error.description}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error loading page: ${error.description}'),
                backgroundColor: Colors.redAccent,
                duration: const Duration(seconds: 5),
              ),
            );
            // Don't automatically pop, let user decide
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint("Navigation request: ${request.url}");
            return NavigationDecision.navigate;
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

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
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as String;
    debugPrint("FRAME URL :: $data");
    return Scaffold(
      backgroundColor: const Color(0xFF11316C),
      appBar: AppBar(
        title: const Text("Maps"),
      ),
      body: WebView(
        initialUrl: data,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          if (url.contains('google.com/maps')) {

            final urls = Uri.parse(url);
             launchUrl(urls, mode: LaunchMode.externalApplication);

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
    );
  }
}
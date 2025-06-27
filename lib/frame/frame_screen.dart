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

  // Helper method to handle Google Maps and verification URLs
  Future<void> _handleGoogleUrl(String url) async {
    try {
      Uri targetUri;
      String mapsUrl = url;

      if (url.contains('google.com/sorry')) {
        // Extract the continue URL from Google's verification page
        final uri = Uri.parse(url);
        String? continueUrl = uri.queryParameters['continue'];
        if (continueUrl != null) {
          mapsUrl = Uri.decodeFull(continueUrl);
          debugPrint("Extracted Maps URL from verification page: $mapsUrl");
        } else {
          debugPrint("No continue URL found, using verification URL");
        }
      }

      // Convert Google Maps web URL to Android Maps intent format
      if (mapsUrl.contains('google.com/maps')) {
        final uri = Uri.parse(mapsUrl);
        
        // Check if it's a directions URL
        if (mapsUrl.contains('/dir/') || uri.queryParameters.containsKey('destination')) {
          String? destination = uri.queryParameters['destination'];
          String? travelMode = uri.queryParameters['travelmode'];
          
          if (destination != null) {
            // Try multiple Android Maps URL formats
            List<String> androidMapsUrls = [];
            
            // Format 1: Google Navigation intent (best for directions)
            if (travelMode != null) {
              androidMapsUrls.add('google.navigation:q=$destination&mode=$travelMode');
            }
            androidMapsUrls.add('google.navigation:q=$destination');
            
            // Format 2: Geo URI for maps
            androidMapsUrls.add('geo:0,0?q=$destination');
            
            // Format 3: Direct Maps intent
            androidMapsUrls.add('https://maps.google.com/?q=$destination');
            
            // Try each format until one works
            bool launched = false;
            for (String urlFormat in androidMapsUrls) {
              try {
                final testUri = Uri.parse(urlFormat);
                if (await canLaunchUrl(testUri)) {
                  await launchUrl(testUri, mode: LaunchMode.externalApplication);
                  launched = true;
                  debugPrint("Successfully launched with format: $urlFormat");
                  break;
                }
              } catch (e) {
                debugPrint("Failed to launch format $urlFormat: $e");
                continue;
              }
            }
            
            if (launched) {
              if (mounted) {
                Navigator.of(context).pop();
              }
              return;
            } else {
              // Fallback to original URL
              targetUri = Uri.parse(mapsUrl);
            }
          } else {
            // Fallback to original URL
            targetUri = Uri.parse(mapsUrl);
          }
        } else {
          // For other Maps URLs, try to extract coordinates or query
          String? query = uri.queryParameters['q'];
          if (query != null) {
            targetUri = Uri.parse('geo:0,0?q=$query');
          } else {
            // Use original URL as fallback
            targetUri = Uri.parse(mapsUrl);
          }
        }
      } else {
        targetUri = Uri.parse(mapsUrl);
      }

      // Try to launch with remaining URL formats if not already launched
      bool launched = false;
      if (await canLaunchUrl(targetUri)) {
        try {
          await launchUrl(targetUri, mode: LaunchMode.externalApplication);
          launched = true;
          debugPrint("Successfully launched URL externally: ${targetUri.toString()}");
        } catch (e) {
          debugPrint("Failed to launch URL: $e");
        }
      }

      if (!launched) {
        debugPrint("Cannot launch any URL format for: $mapsUrl");
        // Show error message to user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unable to open Maps. Please install Google Maps app.'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        // Close the webview since we're opening externally
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      debugPrint("Error handling Google URL: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening Maps: $e'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    url = ModalRoute.of(context)!.settings.arguments as String;
    debugPrint("FRAME URL :: $url");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('Mozilla/5.0 (Linux; Android 13; SM-S911B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Mobile Safari/537.36')
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            debugPrint("Page started loading: $url");
            // Handle Google Maps and verification pages
            if (url.contains('google.com/maps') || url.contains('google.com/sorry')) {
              await _handleGoogleUrl(url);
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
            // Prevent loading Google URLs in webview - launch externally instead
            if (request.url.contains('google.com/maps') || request.url.contains('google.com/sorry')) {
              _handleGoogleUrl(request.url);
              return NavigationDecision.prevent;
            }
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
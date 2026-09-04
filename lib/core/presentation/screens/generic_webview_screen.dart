// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../../extensions/build_context_extensions.dart';

// class GenericWebviewScreen extends StatefulWidget {
//   final String url;
//   final String title;

//   const GenericWebviewScreen({
//     super.key,
//     required this.url,
//     required this.title,
//   });

//   @override
//   State<GenericWebviewScreen> createState() => _GenericWebviewScreenState();
// }

// class _GenericWebviewScreenState extends State<GenericWebviewScreen> {
//   late final WebViewController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     // 🎯 Safely parse the URL (adds https:// if it's missing)
//     String finalUrl = widget.url;
//     if (!finalUrl.startsWith('http')) {
//       finalUrl = 'https://$finalUrl';
//     }

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.transparent) // Prevents white flash
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             debugPrint('🌐 WebView Started Loading: $url');
//             if (mounted && !_isLoading) setState(() => _isLoading = true);
//           },
//           onPageFinished: (String url) {
//             debugPrint('✅ WebView Finished Loading: $url');
//             if (mounted) setState(() => _isLoading = false);
//           },
//           onWebResourceError: (WebResourceError error) {
//             // 🎯 This catches silent failures and stops the infinite spinner!
//             debugPrint('❌ WebView Error: ${error.description}');
//             if (mounted) setState(() => _isLoading = false);
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(finalUrl));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(
//         title: Text(
//           widget.title,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: context.colorScheme.surface,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(
//                 color: context.colorScheme.primary,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../extensions/build_context_extensions.dart';
import '../widgets/sevika_state_placeholder.dart';

class GenericWebviewScreen extends StatefulWidget {
  final String url;
  final String title;

  const GenericWebviewScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<GenericWebviewScreen> createState() => _GenericWebviewScreenState();
}

class _GenericWebviewScreenState extends State<GenericWebviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false; // 🎯 Track if the webpage crashed

  @override
  void initState() {
    super.initState();

    String finalUrl = widget.url;
    if (!finalUrl.startsWith('http')) {
      finalUrl = 'https://$finalUrl';
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('🌐 WebView Started Loading: $url');
            if (mounted) {
              setState(() {
                _isLoading = true;
                _hasError = false; // Reset error on new load
              });
            }
          },
          onPageFinished: (String url) {
            debugPrint('✅ WebView Finished Loading: $url');
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('❌ WebView Error: ${error.description}');
            if (mounted) {
              setState(() {
                _isLoading = false;
                _hasError = true; // Trigger the placeholder!
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(finalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: _hasError
            ? Center(
                // 🎯 Show the beautiful placeholder if the link breaks!
                child: SevikaStatePlaceholder(
                  title: 'Page Failed to Load',
                  message:
                      'We encountered an error while trying to load this page. Please check your connection and try again.',
                  icon: Icons.public_off_rounded,
                  iconColor: context.colorScheme.error,
                  iconBackgroundColor: context.colorScheme.errorContainer
                      .withValues(alpha: 0.3),
                  actionButtonText: 'Reload Page',
                  actionButtonIcon: Icons.refresh_rounded,
                  onActionPressed: () {
                    setState(() {
                      _isLoading = true;
                      _hasError = false;
                    });
                    _controller.reload();
                  },
                ),
              )
            : Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: context.colorScheme.primary,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

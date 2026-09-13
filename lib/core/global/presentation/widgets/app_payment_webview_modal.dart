import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

class AppPaymentWebViewModal extends StatefulWidget {
  final String redirectUrl;
  final String callbackUrlIndicator;

  const AppPaymentWebViewModal({
    super.key,
    required this.redirectUrl,
    // This is the URL base your Laravel backend uses for webhooks/callbacks.
    // When the webview sees this URL, it knows the transaction is done.
    //this.callbackUrlIndicator = 'payments/webhook/callback',
    this.callbackUrlIndicator = 'webhooks/payments/flutterwave/callback',
  });

  @override
  State<AppPaymentWebViewModal> createState() => _AppPaymentWebViewModalState();
}

class _AppPaymentWebViewModalState extends State<AppPaymentWebViewModal> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          // 🎯 THE INTERCEPTOR: This is the magic that makes it feel native
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains(widget.callbackUrlIndicator)) {
              // The bank finished and is trying to hit your callback endpoint!
              // Block the navigation and pop the modal instantly, returning 'true'.
              Navigator.of(context).pop(true);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Makes the bottom sheet take up 90% of the screen height
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
        children: [
          // Native-looking drag handle and close button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48), // Balance spacing
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () =>
                      Navigator.of(context).pop(false), // User aborted
                ),
              ],
            ),
          ),

          // The WebView Frame
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppDimensions.radiusL),
                  ),
                  child: WebViewWidget(controller: _controller),
                ),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator.adaptive()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

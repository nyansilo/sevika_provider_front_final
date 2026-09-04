// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_dimensions.dart';
// import '../../../../../core/extensions/build_context_extensions.dart';

// class ChatInputBar extends StatefulWidget {
//   final Function(String) onSendMessage;
//   final bool isSending;

//   const ChatInputBar({
//     super.key,
//     required this.onSendMessage,
//     this.isSending = false,
//   });

//   @override
//   State<ChatInputBar> createState() => _ChatInputBarState();
// }

// class _ChatInputBarState extends State<ChatInputBar> {
//   final TextEditingController _controller = TextEditingController();
//   bool _hasText = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       setState(() => _hasText = _controller.text.trim().isNotEmpty);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _handleSend() {
//     if (_controller.text.trim().isEmpty || widget.isSending) return;
//     widget.onSendMessage(_controller.text.trim());
//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppDimensions.paddingM,
//         vertical: AppDimensions.paddingS,
//       ),
//       decoration: BoxDecoration(
//         color: context.colorScheme.surface,
//         border: Border(
//           top: BorderSide(
//             color: context.colorScheme.outlineVariant.withValues(
//               alpha: AppDimensions.borderAlphaMuted,
//             ),
//             width: AppDimensions.borderWidthThin,
//           ),
//         ),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 constraints: const BoxConstraints(
//                   minHeight: AppDimensions.targetButtonHeight,
//                 ),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: context.colorScheme.surfaceContainerLow,
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
//                 ),
//                 child: TextField(
//                   controller: _controller,
//                   enabled: !widget.isSending, // Lock input when transmitting
//                   maxLines: 4,
//                   minLines: 1,
//                   textCapitalization: TextCapitalization.sentences,
//                   style: context.textTheme.bodyLarge,
//                   decoration: const InputDecoration(
//                     hintText: 'Type your message...',
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: AppDimensions.paddingM,
//                       vertical: AppDimensions.paddingSM,
//                     ),
//                     border: InputBorder.none,
//                     isDense: true,
//                   ),
//                 ),
//               ),
//             ),
//             AppDimensions.gapS,
//             widget.isSending
//                 ? const Padding(
//                     padding: EdgeInsets.all(AppDimensions.paddingS),
//                     child: SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator.adaptive(strokeWidth: 2),
//                     ),
//                   )
//                 : IconButton.filled(
//                     icon: const Icon(Icons.send_rounded),
//                     iconSize: AppDimensions.iconM,
//                     onPressed: _hasText ? _handleSend : null,
//                     style: IconButton.styleFrom(
//                       minimumSize: const Size(
//                         AppDimensions.targetButtonHeight,
//                         AppDimensions.targetButtonHeight,
//                       ),
//                       backgroundColor: _hasText
//                           ? context.colorScheme.primary
//                           : context.colorScheme.surfaceContainerHigh,
//                       foregroundColor: _hasText
//                           ? context.colorScheme.onPrimary
//                           : context.colorScheme.outline,
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';

class ChatInputBar extends StatefulWidget {
  final Function(String) onSendMessage;

  // 📍 NEW: Optional callback to handle location sharing
  final VoidCallback? onSendLocation;

  final bool isSending;

  const ChatInputBar({
    super.key,
    required this.onSendMessage,
    this.onSendLocation, // 📍 NEW
    this.isSending = false,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _hasText = _controller.text.trim().isNotEmpty);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_controller.text.trim().isEmpty || widget.isSending) return;
    widget.onSendMessage(_controller.text.trim());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions
            .paddingS, // 🎯 Reduced slightly to fit the new icon better
        vertical: AppDimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant.withValues(
              alpha: AppDimensions.borderAlphaMuted,
            ),
            width: AppDimensions.borderWidthThin,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // 📍 NEW: Location Share Button placed natively next to the text input
            if (widget.onSendLocation != null)
              IconButton(
                icon: const Icon(Icons.add_location_alt_outlined),
                iconSize: AppDimensions.iconM,
                color: context.colorScheme.primary,
                tooltip: 'Share Location',
                // Disable button if an API request is actively sending
                onPressed: widget.isSending ? null : widget.onSendLocation,
              ),

            // If no location button is provided, give it standard padding
            if (widget.onSendLocation == null) AppDimensions.gapS,

            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: AppDimensions.targetButtonHeight,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                ),
                child: TextField(
                  controller: _controller,
                  enabled: !widget.isSending, // Lock input when transmitting
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: context.textTheme.bodyLarge,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                      vertical: AppDimensions.paddingSM,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ),
            AppDimensions.gapS,
            widget.isSending
                ? const Padding(
                    padding: EdgeInsets.all(AppDimensions.paddingS),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                    ),
                  )
                : IconButton.filled(
                    icon: const Icon(Icons.send_rounded),
                    iconSize: AppDimensions.iconM,
                    onPressed: _hasText ? _handleSend : null,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(
                        AppDimensions.targetButtonHeight,
                        AppDimensions.targetButtonHeight,
                      ),
                      backgroundColor: _hasText
                          ? context.colorScheme.primary
                          : context.colorScheme.surfaceContainerHigh,
                      foregroundColor: _hasText
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.outline,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

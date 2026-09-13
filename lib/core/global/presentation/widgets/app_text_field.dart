// import 'package:flutter/material.dart';
// import '../constants/app_dimensions.dart';
// import '../extensions/build_context_extensions.dart';

// class AppTextField extends StatelessWidget {
//   final String label;
//   final String hintText;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final TextInputType keyboardType;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final bool isObscured;
//   final int? maxLines;
//   final void Function(String)? onChanged;

//   const AppTextField({
//     super.key,
//     required this.label,
//     required this.hintText,
//     this.controller,
//     this.validator,
//     this.keyboardType = TextInputType.text,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.isObscured = false,
//     this.maxLines = 1,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       keyboardType: keyboardType,
//       obscureText: isObscured,
//       maxLines: maxLines,
//       onChanged: onChanged,
//       style: context.textTheme.bodyLarge,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hintText,
//         prefixIcon: prefixIcon,
//         suffixIcon: suffixIcon,
//         alignLabelWithHint: true,
//         labelStyle: TextStyle(color: context.colorScheme.onSurfaceVariant),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingM,
//           vertical: AppDimensions.paddingM + AppDimensions.radiusXXS,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.size14),
//           borderSide: BorderSide(
//             color: context.colorScheme.outline,
//             width: AppDimensions.borderWidthThin,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.size14),
//           borderSide: BorderSide(
//             color: context.colorScheme.outlineVariant,
//             width: AppDimensions.borderWidthThin,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.size14),
//           borderSide: BorderSide(
//             color: context.colorScheme.primary,
//             width: AppDimensions.borderWidthThick,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.size14),
//           borderSide: BorderSide(
//             color: context.colorScheme.error,
//             width: AppDimensions.borderWidthThin,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../constants/app_dimensions.dart';
// import '../extensions/build_context_extensions.dart';

// class AppTextField extends StatefulWidget {
//   final String? label;
//   final String hintText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final int maxLines;
//   final TextInputAction? textInputAction;
//   final ValueChanged<String>? onChanged;

//   const AppTextField({
//     super.key,
//     this.label,
//     required this.hintText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.controller,
//     this.validator,
//     this.keyboardType,
//     this.obscureText = false,
//     this.maxLines = 1,
//     this.textInputAction,
//     this.onChanged,
//   });

//   @override
//   State<AppTextField> createState() => _AppTextFieldState();
// }

// class _AppTextFieldState extends State<AppTextField> {
//   late bool _isObscured;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize internal state with the parameter value configuration
//     _isObscured = widget.obscureText;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Automatically injects label layout stack if label string is supplied
//         if (widget.label != null) ...[
//           Text(
//             widget.label!,
//             style: context.textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: context.colorScheme.onSurface,
//             ),
//           ),
//           AppDimensions.gapXS,
//         ],
//         TextFormField(
//           controller: widget.controller,
//           validator: widget.validator,
//           keyboardType: widget.keyboardType,
//           obscureText: _isObscured,
//           // Force single-line calculation logic when text is obscured
//           maxLines: widget.obscureText ? 1 : widget.maxLines,
//           textInputAction: widget.textInputAction,
//           onChanged: widget.onChanged,
//           style: context.textTheme.bodyMedium,
//           decoration: InputDecoration(
//             hintText: widget.hintText,
//             hintStyle: context.textTheme.bodyMedium?.copyWith(
//               color: context.colorScheme.outline,
//             ),
//             prefixIcon: widget.prefixIcon,
//             prefixIconColor: context.colorScheme.onSurfaceVariant,
//             // Automatically provides standard interactive eye toggle if it's an obscured field
//             // and no custom alternative override suffixIcon is passed down.
//             suffixIcon:
//                 widget.suffixIcon ??
//                 (widget.obscureText
//                     ? IconButton(
//                         icon: Icon(
//                           _isObscured
//                               ? Icons.visibility_off_rounded
//                               : Icons.visibility_rounded,
//                           size: AppDimensions.iconM,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isObscured = !_isObscured;
//                           });
//                         },
//                       )
//                     : null),
//             suffixIconColor: context.colorScheme.outline,
//             filled: true,
//             fillColor: context.colorScheme.surfaceContainerLow,
//             contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//               borderSide: BorderSide(color: context.colorScheme.outlineVariant),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//               borderSide: BorderSide(color: context.colorScheme.outlineVariant),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//               borderSide: BorderSide(
//                 color: context.colorScheme.primary,
//                 width: AppDimensions.borderWidthMedium,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//               borderSide: BorderSide(color: context.colorScheme.error),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//               borderSide: BorderSide(
//                 color: context.colorScheme.error,
//                 width: AppDimensions.borderWidthMedium,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// core/widgets/app_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLines;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const AppTextField({
    super.key,
    this.label,
    required this.hintText,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        labelStyle: TextStyle(color: context.colorScheme.onSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingM + AppDimensions.radiusXXS,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.size14),
          borderSide: BorderSide(
            color: context.colorScheme.outline,
            width: AppDimensions.borderWidthThin,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.size14),
          borderSide: BorderSide(
            color: context.colorScheme.outlineVariant,
            width: AppDimensions.borderWidthThin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.size14),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: AppDimensions.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.size14),
          borderSide: BorderSide(
            color: context.colorScheme.error,
            width: AppDimensions.borderWidthThin,
          ),
        ),
      ),
    );
  }
}

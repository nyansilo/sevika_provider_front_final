import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart'; // ✅ Native vector graphics streaming

// 🎯 ADDED: Import your ApiEndpoints class to access the sanitizer
import '../../../constants/api_endpoints.dart'; // <-- Adjust path if your ApiEndpoints is located elsewhere

import '../../../constants/app_dimensions.dart';
import 'app_image_placeholder.dart'; // Direct connection to your existing placeholder

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final IconData errorIcon;
  final IconData loadingIcon;
  final Map<String, String>? headers;
  final Color? iconColor; // 🚀 ADDED: Optional asset tint color parameter

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.errorIcon = Icons.image_not_supported_rounded,
    this.loadingIcon = Icons.refresh_rounded,
    this.headers,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    // 🎯 ENGINE LAYER: Sanitize the URL instantly before Flutter tries to do anything with it!
    // This fixes the Localhost Trap and the Ngrok HTML warning screen.
    final String cleanUrl = ApiEndpoints.sanitizeBackendUrl(imageUrl);

    // 🛡️ Edge Case Guard: Handle empty or broken image URLs gracefully
    if (cleanUrl.isEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: AppImagePlaceholder(icon: errorIcon),
        ),
      );
    }

    // 🔍 ENGINE LAYER: Sniff the file signature extension coming down from your Laravel backend
    final bool isSvg = cleanUrl.toLowerCase().endsWith('.svg');

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        // 🎯 Pass the cleanUrl down into your builders
        child: isSvg
            ? _buildSvgImage(context, cleanUrl)
            : _buildStandardImage(context, cleanUrl),
      ),
    );
  }

  /// 📐 Renders Scalable Vector Graphics cleanly
  Widget _buildSvgImage(BuildContext context, String cleanUrl) {
    return SvgPicture.network(
      cleanUrl, // 🎯 Uses sanitized URL
      fit: fit,
      width: width,
      height: height,
      headers: headers, // Reuses headers pipeline if your asset directory is locked behind auth
      // 🎨 Dynamic Layer Tinting: Safely overrides vector fills (like hardcoded raw hex black)
      // 🚀 FORCE CACHE CLEARANCE BY ADDING A UNIQUE KEY SPECIFIER
      key: ValueKey('${cleanUrl}_tint_${iconColor?.toARGB32()}'),
      colorFilter: iconColor != null
          ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
          : null,
      placeholderBuilder: (context) => AppImagePlaceholder(
        icon: loadingIcon,
        iconSize: _determineIconSize(),
      ),
    );
  }

  /// 🖼️ Renders cached raster image files (PNG, JPG, WEBP)
  Widget _buildStandardImage(BuildContext context, String cleanUrl) {
    return CachedNetworkImage(
      imageUrl: cleanUrl, // 🎯 Uses sanitized URL
      fit: fit,
      httpHeaders: headers, // Useful later if your Laravel API needs Bearer tokens for media
      // 🔄 Global Loading Implementation linking your placeholder
      placeholder: (context, url) => AppImagePlaceholder(
        icon: loadingIcon,
        iconSize: _determineIconSize(),
      ),

      // ❌ Global Error Implementation linking your placeholder
      errorWidget: (context, url, error) =>
          AppImagePlaceholder(icon: errorIcon, iconSize: _determineIconSize()),
    );
  }

  /// Centralizes your adaptive size calculations to prevent repetitive code blocks
  double _determineIconSize() {
    return (width != null && width! < AppDimensions.size40)
        ? AppDimensions
              .size16 // Shrink icon size for tiny boxes like small icons
        : AppDimensions.iconM;
  }
}

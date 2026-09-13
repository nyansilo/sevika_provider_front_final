import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/date_formatter_extension.dart';
import '../../domain/enums/kyc_tier.dart';

class KycTierHeaderWidget extends StatelessWidget {
  final KycTier tier;
  final DateTime? verifiedAt;

  const KycTierHeaderWidget({super.key, required this.tier, this.verifiedAt});

  @override
  Widget build(BuildContext context) {
    final bool isVerified = tier != KycTier.unverified;
    final Color tierColor = isVerified
        ? context.colorScheme.primary
        : Colors.grey;
    final String tierText = tier == KycTier.professional
        ? 'Professional Provider'
        : (tier == KycTier.basic ? 'Basic Provider' : 'Unverified');

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: tierColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: tierColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            isVerified ? Icons.verified_rounded : Icons.shield_outlined,
            size: 48,
            color: tierColor,
          ),
          AppDimensions.gapM,
          Text(
            tierText,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: tierColor,
            ),
          ),
          if (verifiedAt != null) ...[
            AppDimensions.gapS,
            Text(
              'Verified since ${verifiedAt!.toStandardDate()}',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

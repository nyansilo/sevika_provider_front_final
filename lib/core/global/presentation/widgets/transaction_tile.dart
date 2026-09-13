import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // <-- Add this missing import

import '../../../extensions/build_context_extensions.dart';

import '../../../extensions/currency_formatter_extensions.dart';
import '../../../utils/mobile_money_helper.dart';
import '../../../constants/app_dimensions.dart';

class TransactionTile extends StatelessWidget {
  final String referenceId;
  final String phoneNumber;
  final double amount;
  final String timestamp;
  final bool isDeposit;
  final String status;

  const TransactionTile({
    super.key,
    required this.referenceId,
    required this.phoneNumber,
    required this.amount,
    required this.timestamp,
    required this.isDeposit,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final String providerAssetPath = MobileMoneyHelper.getAssetIconFromNumber(
      phoneNumber,
    );
    final Color amountColor = isDeposit
        ? Colors.green.shade700
        : context.colorScheme.error;
    final String amountPrefix = isDeposit ? '+' : '-';

    return Container(
      height: AppDimensions.transactionRowHeight,
      margin: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingXS,
        horizontal: AppDimensions.borderWidthThin,
      ),
      padding: const EdgeInsets.all(AppDimensions.size14),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withValues(
            alpha: AppDimensions.borderAlphaSubtle,
          ),
          width: AppDimensions.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppDimensions.size48,
            height: AppDimensions.size48,
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              providerAssetPath,
              placeholderBuilder: (_) => Icon(
                Icons.payment,
                color: context.colorScheme.primary,
                size: AppDimensions.iconL,
              ),
            ),
          ),
          AppDimensions.gapHM,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  referenceId,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimensions.gapVXXS,
                Text(
                  timestamp,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: AppDimensions.fontSizeCaption,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$amountPrefix ${amount.toTzs()}',
                style: context.textTheme.titleMedium?.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppDimensions.gapVXXS,
              Text(
                status,
                style: context.textTheme.bodySmall?.copyWith(
                  color: status.toLowerCase() == 'failed'
                      ? context.colorScheme.error
                      : Colors.grey.shade600,
                  fontSize: AppDimensions.fontSizeCaption,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

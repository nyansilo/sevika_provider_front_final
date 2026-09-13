// import 'package:flutter/material.dart';

// import '../../constants/ui_strings.dart';
// import '../../constants/app_dimensions.dart';
// import '../../extensions/build_context_extensions.dart';
// import '../../extensions/currency_formatter_extensions.dart';

// class WalletBalanceCard extends StatefulWidget {
//   final double currentBalance;
//   final VoidCallback onTopUpPressed;
//   final VoidCallback onWithdrawPressed;

//   const WalletBalanceCard({
//     super.key,
//     required this.currentBalance,
//     required this.onTopUpPressed,
//     required this.onWithdrawPressed,
//   });

//   @override
//   State<WalletBalanceCard> createState() => _WalletBalanceCardState();
// }

// class _WalletBalanceCardState extends State<WalletBalanceCard> {
//   bool _isBalanceHidden = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: AppDimensions.walletCardHeight,
//       padding: const EdgeInsets.all(AppDimensions.size20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             context.colorScheme.primary,
//             context.colorScheme.primaryContainer,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
//         boxShadow: [
//           BoxShadow(
//             color: context.colorScheme.primary.withValues(
//               alpha: AppDimensions.containerAlphaMed,
//             ),
//             blurRadius: AppDimensions.size12,
//             offset: const Offset(0, AppDimensions.paddingXS),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 UiStrings.walletBalanceLabel,
//                 style: context.textTheme.bodyMedium?.copyWith(
//                   color: context.colorScheme.onPrimary.withValues(
//                     alpha: AppDimensions.containerAlphaHigh,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   _isBalanceHidden ? Icons.visibility_off : Icons.visibility,
//                   color: context.colorScheme.onPrimary,
//                   size: AppDimensions.iconM,
//                 ),
//                 onPressed: () =>
//                     setState(() => _isBalanceHidden = !_isBalanceHidden),
//               ),
//             ],
//           ),
//           AppDimensions.gapVXXS,
//           Text(
//             _isBalanceHidden ? '••••••••••' : widget.currentBalance.toTzs(),
//             style: context.textTheme.headlineMedium?.copyWith(
//               color: context.colorScheme.onPrimary,
//               fontWeight: FontWeight.bold,
//               fontSize: AppDimensions.fontSizeDisplay,
//               letterSpacing: _isBalanceHidden
//                   ? AppDimensions.borderWidthThick
//                   : AppDimensions.borderAlphaSubtle,
//             ),
//           ),
//           AppDimensions.gapVM,
//           Row(
//             children: [
//               Expanded(
//                 child: _ActionSubButton(
//                   label: UiStrings.walletTopUp,
//                   icon: Icons.add_circle_outline,
//                   onTap: widget.onTopUpPressed,
//                 ),
//               ),
//               const SizedBox(width: AppDimensions.size12),
//               Expanded(
//                 child: _ActionSubButton(
//                   label: UiStrings.walletWithdraw,
//                   icon: Icons.account_balance_wallet_outlined,
//                   onTap: widget.onWithdrawPressed,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActionSubButton extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final VoidCallback onTap;

//   const _ActionSubButton({
//     required this.label,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: AppDimensions.size12),
//         decoration: BoxDecoration(
//           color: context.colorScheme.onPrimary.withValues(
//             alpha: AppDimensions.borderAlphaMuted,
//           ),
//           borderRadius: BorderRadius.circular(AppDimensions.radiusM),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: AppDimensions.iconS,
//               color: context.colorScheme.onPrimary,
//             ),
//             AppDimensions.gapHXS,
//             Text(
//               label,
//               style: context.textTheme.titleSmall?.copyWith(
//                 color: context.colorScheme.onPrimary,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../constants/ui_strings.dart';
import '../../../constants/app_dimensions.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../extensions/currency_formatter_extensions.dart';

class WalletBalanceCard extends StatefulWidget {
  final double currentBalance;
  final VoidCallback onTopUpPressed;
  final VoidCallback onWithdrawPressed;

  const WalletBalanceCard({
    super.key,
    required this.currentBalance,
    required this.onTopUpPressed,
    required this.onWithdrawPressed,
  });

  @override
  State<WalletBalanceCard> createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends State<WalletBalanceCard> {
  bool _isBalanceHidden = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // 🎯 FIXED: Removed rigid fixed height to allow natural expansion without bottom RenderFlex overflow
      padding: const EdgeInsets.all(AppDimensions.size20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary,
            context.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(
              alpha: AppDimensions.containerAlphaMed,
            ),
            blurRadius: AppDimensions.size12,
            offset: const Offset(0, AppDimensions.paddingXS),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 🎯 Wrap content tightly
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                UiStrings.walletBalanceLabel,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onPrimary.withValues(
                    alpha: AppDimensions.containerAlphaHigh,
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  _isBalanceHidden ? Icons.visibility_off : Icons.visibility,
                  color: context.colorScheme.onPrimary,
                  size: AppDimensions.iconM,
                ),
                onPressed: () =>
                    setState(() => _isBalanceHidden = !_isBalanceHidden),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              _isBalanceHidden ? '••••••••••' : widget.currentBalance.toTzs(),
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.fontSizeDisplay,
                letterSpacing: _isBalanceHidden
                    ? AppDimensions.borderWidthThick
                    : AppDimensions.borderAlphaSubtle,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ActionSubButton(
                  label: UiStrings.walletTopUp,
                  icon: Icons.add_circle_outline,
                  onTap: widget.onTopUpPressed,
                ),
              ),
              const SizedBox(width: AppDimensions.size12),
              Expanded(
                child: _ActionSubButton(
                  label: UiStrings.walletWithdraw,
                  icon: Icons.account_balance_wallet_outlined,
                  onTap: widget.onWithdrawPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionSubButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionSubButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.size12),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary.withValues(
            alpha: AppDimensions.borderAlphaMuted,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconS,
              color: context.colorScheme.onPrimary,
            ),
            AppDimensions.gapHXS,
            Text(
              label,
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

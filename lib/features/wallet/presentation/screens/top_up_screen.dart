import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
// 🎯 Import your provided global widgets
import '../../../../core/presentation/widgets/sevika_alert_dialog.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _amountController = TextEditingController();
  bool _isLoading = false;

  void _handleTopUp() {
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (amount < 1000) {
      context.showSnackBar(
        'Minimum top-up amount is 1,000 TSh',
        type: SnackBarType.error,
      );
      return;
    }

    // 🎯 Utilize your provided Global Alert Dialog!
    showSevikaAlertDialog(
      context: context,
      title: 'Confirm Top Up',
      content:
          'You are about to initiate a push payment to your mobile number for $amount TSh to fund your Sevika Wallet.',
      primaryActionText: 'Proceed',
      primaryIsFilled: true,
      onPrimaryAction: () async {
        Navigator.pop(context); // Close dialog

        setState(() => _isLoading = true);

        // TODO: Call your TopUpCubit or API here (Simulated delay for UI)
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          setState(() => _isLoading = false);
          context.showSnackBar(
            'Payment prompt sent to your phone! Complete it to reflect balance.',
            type: SnackBarType.success,
          );
          Navigator.pop(context); // Pop back to dashboard
        }
      },
      secondaryActionText: 'Cancel',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(title: const Text('Top Up Wallet'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add funds to your wallet to cover upcoming lead fees or platform commissions.',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            AppDimensions.gapXL,

            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Top Up Amount (TSh)',
                prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                ),
              ),
            ),
            AppDimensions.gapL,

            // Fast selection chips
            Wrap(
              spacing: AppDimensions.paddingXL,
              children: [5000, 10000, 20000]
                  .map(
                    (val) => ActionChip(
                      label: Text('+ $val'),
                      onPressed: () {
                        _amountController.text = val.toString();
                      },
                    ),
                  )
                  .toList(),
            ),

            const Spacer(),

            // 🎯 REPLACED: Utilizing your custom SevikaButton
            SevikaButton(
              text: 'Initiate Top Up',
              icon: Icons.payments_rounded,
              isLoading: _isLoading,
              onPressed: _handleTopUp,
            ),
            AppDimensions.gapXL,
          ],
        ),
      ),
    );
  }
}

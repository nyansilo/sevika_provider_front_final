// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../domain/enums/withdrawal_channel.dart';
// import '../../domain/usecases/params/request_withdrawal_params.dart';
// import '../cubits/withdrawal_state.dart';
// import '../cubits/withdrawal_cubit.dart';

// class RequestWithdrawalScreen extends StatefulWidget {
//   const RequestWithdrawalScreen({super.key});

//   @override
//   State<RequestWithdrawalScreen> createState() =>
//       _RequestWithdrawalScreenState();
// }

// class _RequestWithdrawalScreenState extends State<RequestWithdrawalScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _accountNumberController = TextEditingController();
//   final _accountNameController = TextEditingController();
//   WithdrawalChannel _selectedChannel = WithdrawalChannel.mPesa;

//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;

//     final amount = double.tryParse(_amountController.text) ?? 0.0;

//     context.read<WithdrawalCubit>().submitWithdrawal(
//       RequestWithdrawalParams(
//         amount: amount,
//         channel: _selectedChannel,
//         accountNumber: _accountNumberController.text,
//         accountName: _accountNameController.text,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _amountController.dispose();
//     _accountNumberController.dispose();
//     _accountNameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Request Cash-Out')),
//       // 🎯 BlocConsumer is required here to execute navigation side-effects!
//       body: BlocConsumer<WithdrawalCubit, WithdrawalState>(
//         listener: (context, state) {
//           if (state is WithdrawalSuccess) {
//             context.showSnackBar(
//               'Withdrawal request submitted successfully!',
//               type: SnackBarType.success,
//             );
//             Navigator.pop(context); // Go back to wallet dashboard
//           } else if (state is WithdrawalFailure) {
//             context.showSnackBar(state.message, type: SnackBarType.error);
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is WithdrawalLoading;

//           return Form(
//             key: _formKey,
//             child: ListView(
//               padding: const EdgeInsets.all(AppDimensions.paddingM),
//               children: [
//                 const Text(
//                   'Enter amount to withdraw from your available balance.',
//                 ),
//                 AppDimensions.gapL,

//                 TextFormField(
//                   controller: _amountController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Amount (TSh)',
//                     prefixIcon: Icon(Icons.attach_money_rounded),
//                   ),
//                   validator: (val) {
//                     final amount = double.tryParse(val ?? '0') ?? 0;
//                     if (amount < 5000) return 'Minimum withdrawal is 5,000 TSh';
//                     return null;
//                   },
//                 ),
//                 AppDimensions.gapM,

//                 DropdownButtonFormField<WithdrawalChannel>(
//                   value: _selectedChannel,
//                   decoration: const InputDecoration(
//                     labelText: 'Transfer Network',
//                     prefixIcon: Icon(Icons.account_balance_rounded),
//                   ),
//                   items: WithdrawalChannel.values.map((channel) {
//                     return DropdownMenuItem(
//                       value: channel,
//                       child: Text(channel.displayName),
//                     );
//                   }).toList(),
//                   onChanged: (val) => setState(() => _selectedChannel = val!),
//                 ),
//                 AppDimensions.gapM,

//                 TextFormField(
//                   controller: _accountNumberController,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     labelText: 'Account / Phone Number',
//                     prefixIcon: Icon(Icons.phone_iphone_rounded),
//                   ),
//                   validator: (val) => val == null || val.length < 9
//                       ? 'Enter a valid account number'
//                       : null,
//                 ),
//                 AppDimensions.gapM,

//                 TextFormField(
//                   controller: _accountNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Registered Account Name',
//                     prefixIcon: Icon(Icons.person_rounded),
//                   ),
//                   validator: (val) => val == null || val.isEmpty
//                       ? 'Account name is required'
//                       : null,
//                 ),
//                 AppDimensions.gapXL,

//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   onPressed: isLoading ? null : _submit,
//                   child: isLoading
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         )
//                       : const Text('Submit Request'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../../domain/enums/withdrawal_channel.dart';
import '../../domain/usecases/params/request_withdrawal_params.dart';
import '../cubits/withdrawal_state.dart';
import '../cubits/withdrawal_cubit.dart';

class RequestWithdrawalScreen extends StatefulWidget {
  const RequestWithdrawalScreen({super.key});

  @override
  State<RequestWithdrawalScreen> createState() =>
      _RequestWithdrawalScreenState();
}

class _RequestWithdrawalScreenState extends State<RequestWithdrawalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();
  WithdrawalChannel _selectedChannel = WithdrawalChannel.mPesa;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text) ?? 0.0;

    context.read<WithdrawalCubit>().submitWithdrawal(
      RequestWithdrawalParams(
        amount: amount,
        channel: _selectedChannel,
        accountNumber: _accountNumberController.text,
        accountName: _accountNameController.text,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Cash-Out')),
      // 🎯 BlocConsumer is required here to execute navigation side-effects!
      body: BlocConsumer<WithdrawalCubit, WithdrawalState>(
        listener: (context, state) {
          if (state is WithdrawalSuccess) {
            context.showSnackBar(
              'Withdrawal request submitted successfully!',
              type: SnackBarType.success,
            );
            Navigator.pop(context); // Go back to wallet dashboard
          } else if (state is WithdrawalFailure) {
            context.showSnackBar(state.message, type: SnackBarType.error);
          }
        },
        builder: (context, state) {
          final isLoading = state is WithdrawalLoading;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              children: [
                const Text(
                  'Enter amount to withdraw from your available balance.',
                ),
                AppDimensions.gapL,

                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount (TSh)',
                    prefixIcon: Icon(Icons.attach_money_rounded),
                  ),
                  validator: (val) {
                    final amount = double.tryParse(val ?? '0') ?? 0;
                    if (amount < 5000) return 'Minimum withdrawal is 5,000 TSh';
                    return null;
                  },
                ),
                AppDimensions.gapM,

                DropdownButtonFormField<WithdrawalChannel>(
                  // 🎯 FIXED: Replaced deprecated 'value' with 'initialValue'
                  initialValue: _selectedChannel,
                  decoration: const InputDecoration(
                    labelText: 'Transfer Network',
                    prefixIcon: Icon(Icons.account_balance_rounded),
                  ),
                  items: WithdrawalChannel.values.map((channel) {
                    return DropdownMenuItem(
                      value: channel,
                      child: Text(channel.displayName),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedChannel = val);
                    }
                  },
                ),
                AppDimensions.gapM,

                TextFormField(
                  controller: _accountNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Account / Phone Number',
                    prefixIcon: Icon(Icons.phone_iphone_rounded),
                  ),
                  validator: (val) => val == null || val.length < 9
                      ? 'Enter a valid account number'
                      : null,
                ),
                AppDimensions.gapM,

                TextFormField(
                  controller: _accountNameController,
                  decoration: const InputDecoration(
                    labelText: 'Registered Account Name',
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? 'Account name is required'
                      : null,
                ),
                AppDimensions.gapXL,

                // 🎯 FIXED: Swapped ElevatedButton with your custom SevikaButton
                SevikaButton(
                  text: 'Submit Request',
                  isLoading: isLoading,
                  onPressed: _submit,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

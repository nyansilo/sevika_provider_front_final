import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/currency_formatter_extensions.dart';
import '../cubits/single_payout_cubit.dart';
import '../cubits/single_payout_state.dart';

class PayoutDetailsScreen extends StatefulWidget {
  final String payoutId;
  const PayoutDetailsScreen({super.key, required this.payoutId});

  @override
  State<PayoutDetailsScreen> createState() => _PayoutDetailsScreenState();
}

class _PayoutDetailsScreenState extends State<PayoutDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SinglePayoutCubit>().fetchPayoutDetails(widget.payoutId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(title: const Text('Payout Details')),
      body: BlocBuilder<SinglePayoutCubit, SinglePayoutState>(
        builder: (context, state) {
          if (state is SinglePayoutLoading || state is SinglePayoutInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SinglePayoutFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: context.colorScheme.error),
              ),
            );
          }
          if (state is SinglePayoutLoaded) {
            final payout = state.payout;
            final isCleared = payout.escrowStatus.toLowerCase() == 'cleared';

            return ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Column(
                      children: [
                        Text(
                          'NET EARNINGS',
                          style: context.textTheme.labelLarge?.copyWith(
                            letterSpacing: 1.2,
                            color: Colors.grey,
                          ),
                        ),
                        AppDimensions.gapS,
                        Text(
                          payout.netEarnings.toInt().toTzs(),
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        AppDimensions.gapM,
                        Chip(
                          backgroundColor: isCleared
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                          label: Text(
                            isCleared ? 'CLEARED' : 'HELD IN ESCROW',
                            style: TextStyle(
                              color: isCleared ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppDimensions.gapL,
                Text(
                  'Transaction Info',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimensions.gapM,
                _buildDetailRow(
                  context,
                  'Booking Ref',
                  payout.bookingReference ?? 'N/A',
                ),
                const Divider(),
                _buildDetailRow(context, 'Service', payout.serviceTitle),
                const Divider(),
                _buildDetailRow(context, 'Client', payout.clientName),
                const Divider(),
                _buildDetailRow(
                  context,
                  'Payment Gateway',
                  payout.gatewayMethod.toUpperCase(),
                ),
                const Divider(),
                if (payout.allocatedTime != null)
                  _buildDetailRow(
                    context,
                    'Date Allocated',
                    DateFormat('MMM d, yyyy - h:mm a')
                        .format(payout.allocatedTime!),
                  ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

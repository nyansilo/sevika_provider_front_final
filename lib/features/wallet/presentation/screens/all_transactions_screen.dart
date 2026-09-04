import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/currency_formatter_extensions.dart';

import '../../../../core/presentation/widgets/app_empty_state_placeholder.dart';
import '../../../../core/presentation/widgets/sevika_state_placeholder.dart';
import '../cubits/wallet_transactions_cubit.dart';
import '../cubits/wallet_transactions_state.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<WalletTransactionsCubit>().loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(title: const Text('All Transactions'), centerTitle: true),
      body: BlocBuilder<WalletTransactionsCubit, WalletTransactionsState>(
        builder: (context, state) {
          if (state is WalletTransactionsInitial ||
              state is WalletTransactionsFirstPageLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WalletTransactionsLoadFailure) {
            // 🎯 Full-screen error recovery widget with retry action
            return Center(
              child: SevikaStatePlaceholder(
                icon: Icons.wifi_off_rounded,
                iconColor: context.colorScheme.error,
                iconBackgroundColor: context.colorScheme.errorContainer,
                title: 'Unable to Load History',
                message: state.message,
                actionButtonText: 'Try Again',
                actionButtonIcon: Icons.refresh_rounded,
                onActionPressed: () => context
                    .read<WalletTransactionsCubit>()
                    .loadInitialTransactions(),
              ),
            );
          }

          if (state is WalletTransactionsLoadSuccess) {
            if (state.transactions.isEmpty) {
              return const AppEmptyStatePlaceholder(
                icon: Icons.receipt_long_rounded,
                message: 'No transaction history found.',
              );
            }

            return RefreshIndicator(
              onRefresh: () => context
                  .read<WalletTransactionsCubit>()
                  .loadInitialTransactions(),
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingM,
                ),
                itemCount: state.transactions.length + (state.hasMore ? 1 : 0),
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, indent: 70),
                itemBuilder: (context, index) {
                  if (index >= state.transactions.length) {
                    return const Padding(
                      padding: EdgeInsets.all(AppDimensions.paddingL),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final txn = state.transactions[index];
                  final isCredit = txn.type.toLowerCase() == 'credit';

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingL,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: isCredit
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.1),
                      child: Icon(
                        isCredit ? Icons.add_rounded : Icons.remove_rounded,
                        color: isCredit ? Colors.green : Colors.orange,
                      ),
                    ),
                    title: Text(
                      txn.description,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Ref: ${txn.bookingReference ?? txn.transactionId}\n${txn.createdAt != null ? txn.createdAt.toString().split(' ')[0] : ''}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    isThreeLine: true,
                    trailing: Text(
                      '${isCredit ? '+' : '-'}${txn.amount.toTzs()}',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: isCredit
                            ? Colors.green
                            : context.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

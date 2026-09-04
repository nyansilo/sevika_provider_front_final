// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/extensions/currency_formatter_extensions.dart';
// import '../../../../core/routes/route_list.dart'; // 🎯 ADDED
// import '../cubits/wallet_cubit.dart';
// import '../cubits/wallet_state.dart';
// import '../cubits/wallet_transactions_cubit.dart';
// import '../cubits/wallet_transactions_state.dart';

// class WalletDashboardScreen extends StatefulWidget {
//   const WalletDashboardScreen({super.key});

//   @override
//   State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
// }

// class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     // 🎯 Trigger initial data loads
//     context.read<WalletCubit>().fetchWallet();
//     context.read<WalletTransactionsCubit>().loadInitialTransactions();

//     // 🎯 Infinite Scroll Pagination Listener
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//           _scrollController.position.maxScrollExtent - 200) {
//         context.read<WalletTransactionsCubit>().loadNextPage();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(title: const Text('My Wallet'), centerTitle: true),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           context.read<WalletCubit>().fetchWallet();
//           await context
//               .read<WalletTransactionsCubit>()
//               .loadInitialTransactions();
//         },
//         child: CustomScrollView(
//           controller: _scrollController,
//           physics: const AlwaysScrollableScrollPhysics(),
//           slivers: [
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(AppDimensions.paddingM),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildBalanceCard(context),
//                     AppDimensions.gapL,
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                         ),
//                         // 🎯 FIXED: Implemented routing via centralized RouteList
//                         onPressed: () => Navigator.pushNamed(
//                           context,
//                           RouteList.requestWithdrawalPage,
//                         ),
//                         icon: const Icon(Icons.account_balance_wallet_rounded),
//                         label: const Text('Request Cash-Out'),
//                       ),
//                     ),
//                     AppDimensions.gapXL,
//                     Text(
//                       'Recent Transactions',
//                       style: context.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     AppDimensions.gapS,
//                   ],
//                 ),
//               ),
//             ),

//             // 🎯 TRANSACTIONS LIST INTEGRATION
//             BlocBuilder<WalletTransactionsCubit, WalletTransactionsState>(
//               builder: (context, state) {
//                 if (state is WalletTransactionsInitial ||
//                     (state is WalletTransactionsFirstPageLoading)) {
//                   return const SliverToBoxAdapter(
//                     child: Padding(
//                       padding: EdgeInsets.all(AppDimensions.paddingXL),
//                       child: Center(child: CircularProgressIndicator()),
//                     ),
//                   );
//                 }

//                 if (state is WalletTransactionsLoadFailure) {
//                   return SliverToBoxAdapter(
//                     child: Center(
//                       child: Text(
//                         state.message,
//                         style: TextStyle(color: context.colorScheme.error),
//                       ),
//                     ),
//                   );
//                 }

//                 if (state is WalletTransactionsLoadSuccess) {
//                   if (state.transactions.isEmpty) {
//                     return const SliverToBoxAdapter(
//                       child: Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(AppDimensions.paddingXL),
//                           child: Text(
//                             'No transactions yet.',
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                     );
//                   }

//                   return SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         if (index >= state.transactions.length) {
//                           return state.hasMore
//                               ? const Padding(
//                                   padding: EdgeInsets.all(16.0),
//                                   child: Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 )
//                               : const SizedBox.shrink();
//                         }

//                         final txn = state.transactions[index];
//                         final isCredit = txn.type.toLowerCase() == 'credit';

//                         return ListTile(
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: AppDimensions.paddingM,
//                           ),
//                           leading: CircleAvatar(
//                             backgroundColor: isCredit
//                                 ? Colors.green.withValues(alpha: 0.1)
//                                 : Colors.red.withValues(alpha: 0.1),
//                             child: Icon(
//                               isCredit
//                                   ? Icons.arrow_downward_rounded
//                                   : Icons.arrow_upward_rounded,
//                               color: isCredit ? Colors.green : Colors.red,
//                             ),
//                           ),
//                           title: Text(
//                             txn.description,
//                             style: const TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           subtitle: Text(
//                             txn.bookingReference ?? txn.transactionId,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           trailing: Text(
//                             '${isCredit ? '+' : '-'}${txn.amount.toInt().toTzs()}',
//                             style: context.textTheme.titleMedium?.copyWith(
//                               color: isCredit
//                                   ? Colors.green
//                                   : context.colorScheme.onSurface,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         );
//                       },
//                       childCount:
//                           state.transactions.length + (state.hasMore ? 1 : 0),
//                     ),
//                   );
//                 }
//                 return const SliverToBoxAdapter(child: SizedBox.shrink());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBalanceCard(BuildContext context) {
//     // ... [No changes required to balance card rendering]
//     return BlocBuilder<WalletCubit, WalletState>(
//       builder: (context, state) {
//         if (state is WalletLoading || state is WalletInitial) {
//           return const SizedBox(
//             height: 150,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state is WalletLoaded) {
//           final wallet = state.wallet;
//           return Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(AppDimensions.paddingL),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   context.colorScheme.primary,
//                   context.colorScheme.primaryContainer,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(AppDimensions.radiusL),
//               boxShadow: [
//                 BoxShadow(
//                   color: context.colorScheme.primary.withValues(alpha: 0.3),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   'Available Balance',
//                   style: context.textTheme.titleMedium?.copyWith(
//                     color: context.colorScheme.onPrimary,
//                   ),
//                 ),
//                 AppDimensions.gapS,
//                 Text(
//                   wallet.availableBalance.toInt().toTzs(),
//                   style: context.textTheme.headlineLarge?.copyWith(
//                     color: context.colorScheme.onPrimary,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 AppDimensions.gapM,
//                 if (wallet.heldEscrowBalance > 0)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withValues(alpha: 0.2),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.lock_outline_rounded,
//                           size: 14,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           '${wallet.heldEscrowBalance.toInt().toTzs()} in Escrow',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             ),
//           );
//         }

//         return const Center(child: Text('Failed to load wallet data.'));
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/currency_formatter_extensions.dart';
import '../../../../core/presentation/widgets/app_empty_state_placeholder.dart';
import '../../../../core/presentation/widgets/sevika_state_placeholder.dart';
import '../../../../core/presentation/widgets/wallet_balance_card.dart';
import '../../../../core/routes/route_list.dart'; // 🎯 Centralized routes

import '../cubits/wallet_cubit.dart';
import '../cubits/wallet_state.dart';
import '../cubits/wallet_transactions_cubit.dart';
import '../cubits/wallet_transactions_state.dart';

class WalletDashboardScreen extends StatefulWidget {
  const WalletDashboardScreen({super.key});

  @override
  State<WalletDashboardScreen> createState() => _WalletDashboardScreenState();
}

class _WalletDashboardScreenState extends State<WalletDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // 🎯 Fetch balance and latest transactions for preview
    context.read<WalletCubit>().fetchWallet();
    context.read<WalletTransactionsCubit>().loadInitialTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(title: const Text('My Wallet'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WalletCubit>().fetchWallet();
          await context
              .read<WalletTransactionsCubit>()
              .loadInitialTransactions();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🎯 Balance card with top-up & withdrawal actions
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoading || state is WalletInitial) {
                    return const SizedBox(
                      height: 160,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is WalletFailure) {
                    return SevikaStatePlaceholder(
                      icon: Icons.wifi_off_rounded,
                      iconColor: context.colorScheme.error,
                      iconBackgroundColor: context.colorScheme.errorContainer,
                      title: 'Failed to Load Wallet',
                      message: state.message,
                      actionButtonText: 'Retry',
                      actionButtonIcon: Icons.refresh_rounded,
                      onActionPressed: () =>
                          context.read<WalletCubit>().fetchWallet(),
                    );
                  }

                  if (state is WalletLoaded) {
                    return WalletBalanceCard(
                      currentBalance: state.wallet.availableBalance,
                      onTopUpPressed: () =>
                          Navigator.pushNamed(context, RouteList.topUpPage),
                      onWithdrawPressed: () => Navigator.pushNamed(
                        context,
                        RouteList.requestWithdrawalPage,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              AppDimensions.gapXL,

              // 🎯 Header with navigation to full history
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      RouteList.allTransactionsPage,
                    ),
                    child: const Text('See All'),
                  ),
                ],
              ),
              AppDimensions.gapS,

              // 🎯 Render only the few latest transactions (capped at 5)
              BlocBuilder<WalletTransactionsCubit, WalletTransactionsState>(
                builder: (context, state) {
                  if (state is WalletTransactionsInitial ||
                      state is WalletTransactionsFirstPageLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(AppDimensions.paddingXL),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is WalletTransactionsLoadFailure) {
                    return SevikaStatePlaceholder(
                      icon: Icons.wifi_off_rounded,
                      iconColor: context.colorScheme.error,
                      iconBackgroundColor: context.colorScheme.errorContainer,
                      title: 'Unable to Load Transactions',
                      message: state.message,
                      actionButtonText: 'Retry',
                      actionButtonIcon: Icons.refresh_rounded,
                      onActionPressed: () => context
                          .read<WalletTransactionsCubit>()
                          .loadInitialTransactions(),
                    );
                  }

                  if (state is WalletTransactionsLoadSuccess) {
                    if (state.transactions.isEmpty) {
                      return const AppEmptyStatePlaceholder(
                        icon: Icons.receipt_long_rounded,
                        message: 'No transactions yet. Complete jobs or top-up your wallet to see activity here.',
                      );
                    }

                    // 🎯 Limit preview to top 5 items on the dashboard
                    final recentTransactions = state.transactions
                        .take(5)
                        .toList();

                    return Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusL,
                        ),
                        border: Border.all(
                          color: context.colorScheme.outlineVariant.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recentTransactions.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          indent: 68,
                          color: context.colorScheme.outlineVariant.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          final txn = recentTransactions[index];
                          final isCredit = txn.type.toLowerCase() == 'credit';

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isCredit
                                  ? Colors.green.withValues(alpha: 0.1)
                                  : Colors.red.withValues(alpha: 0.1),
                              child: Icon(
                                isCredit
                                    ? Icons.arrow_downward_rounded
                                    : Icons.arrow_upward_rounded,
                                color: isCredit ? Colors.green : Colors.red,
                              ),
                            ),
                            title: Text(
                              txn.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              txn.bookingReference ?? txn.transactionId,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
              AppDimensions.gapXXL,
            ],
          ),
        ),
      ),
    );
  }
}

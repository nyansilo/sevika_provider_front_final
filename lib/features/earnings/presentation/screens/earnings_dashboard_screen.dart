import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/extensions/currency_formatter_extensions.dart';
import '../../../../core/routes/route_list.dart';
import '../../domain/entities/earnings_analytics_entity.dart';
import '../cubits/earnings_cubit.dart';
import '../cubits/earnings_state.dart';

class EarningsDashboardScreen extends StatefulWidget {
  const EarningsDashboardScreen({super.key});

  @override
  State<EarningsDashboardScreen> createState() =>
      _EarningsDashboardScreenState();
}

class _EarningsDashboardScreenState extends State<EarningsDashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<EarningsCubit>().loadInitialEarnings();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<EarningsCubit>().loadNextPage();
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
      appBar: AppBar(
        title: const Text('Earnings & Invoices'),
        centerTitle: true,
      ),
      body: BlocBuilder<EarningsCubit, EarningsState>(
        builder: (context, state) {
          if (state is EarningsInitial || state is EarningsFirstPageLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EarningsLoadFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: context.colorScheme.error),
              ),
            );
          }

          if (state is EarningsLoadSuccess) {
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<EarningsCubit>().loadInitialEarnings(),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAnalyticsHeader(context, state.analytics),
                          AppDimensions.gapXL,
                          Text(
                            'Payout Ledger',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppDimensions.gapS,
                        ],
                      ),
                    ),
                  ),

                  // 🎯 PAGINATED LEDGER LIST
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index >= state.ledger.length) {
                        return state.hasMore
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox.shrink();
                      }
                      final item = state.ledger[index];
                      final isCash = item.gatewayMethod.toLowerCase() == 'cash';

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isCash
                                ? Colors.orange.withValues(alpha: 0.2)
                                : Colors.blue.withValues(alpha: 0.2),
                            child: Icon(
                              isCash
                                  ? Icons.money_rounded
                                  : Icons.credit_card_rounded,
                              color: isCash ? Colors.orange : Colors.blue,
                            ),
                          ),
                          title: Text(
                            item.serviceTitle,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            'Client: ${item.clientName}\n${item.bookingReference ?? ''}',
                          ),
                          isThreeLine: true,
                          trailing: Text(
                            // 🚀 DIRECT EXTENSION CALL: No .toInt() needed!
                            item.netEarnings.toTzs(),
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteList.payoutDetailsPage,
                              arguments: item.payoutId,
                            );
                          },
                        ),
                      );
                    }, childCount: state.ledger.length + (state.hasMore ? 1 : 0)),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // 🎯 STRICTLY TYPED Entity Parameter allows extensions to work flawlessly
  Widget _buildAnalyticsHeader(
    BuildContext context,
    EarningsAnalyticsEntity analytics,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.payments_outlined, color: Colors.blue),
                    AppDimensions.gapS,
                    const Text('Digital Gateways'),
                  ],
                ),
                Text(
                  // 🚀 DIRECT EXTENSION CALL
                  analytics.digitalGatewayVolume.toTzs(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.money_outlined, color: Colors.orange),
                    AppDimensions.gapS,
                    const Text('Cash on Delivery'),
                  ],
                ),
                Text(
                  // 🚀 DIRECT EXTENSION CALL
                  analytics.cashOnDeliveryVolume.toTzs(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.green),
                    AppDimensions.gapS,
                    const Text('Total Withdrawn'),
                  ],
                ),
                Text(
                  // 🚀 DIRECT EXTENSION CALL
                  analytics.totalWithdrawn.toTzs(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

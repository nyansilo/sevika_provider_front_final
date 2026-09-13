import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_dimensions.dart';
import '../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../core/routes/route_list.dart';

import '../../../../core/global/presentation/widgets/sevika_state_placeholder.dart';
import '../../domain/entities/provider_service_entity.dart';
import '../../domain/enums/service_status.dart';
import '../cubits/provider_service_cubit.dart';
import '../cubits/provider_service_state.dart';
import '../widgets/portfolio/portfolio_service_card.dart';
import '../args/service_action_args.dart'; // 🎯 typed args

class ServicePortfolioScreen extends StatefulWidget {
  const ServicePortfolioScreen({super.key});

  @override
  State<ServicePortfolioScreen> createState() => _ServicePortfolioScreenState();
}

class _ServicePortfolioScreenState extends State<ServicePortfolioScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProviderServiceCubit>().fetchCatalog();
    });
  }

  Future<void> _onRefresh() async {
    await context.read<ProviderServiceCubit>().fetchCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          title: const Text('My Service Portfolio'),
          centerTitle: true,
          backgroundColor: context.colorScheme.surface,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: context.colorScheme.primary,
            labelColor: context.colorScheme.primary,
            unselectedLabelColor: context.colorScheme.onSurfaceVariant,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.symmetric(horizontal: 24),
            tabs: const [
              Tab(text: 'All Services'),
              Tab(text: 'Active'),
              Tab(text: 'Pending'),
              Tab(text: 'Needs Attention'),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // 🚀 WAIT for the Add screen to close
            await Navigator.pushNamed(
              context,
              RouteList.addEditServicePage,
              arguments: ServiceActionArgs(),
            );

            // 🚀 THEN automatically refresh the catalog!
            if (context.mounted) {
              context.read<ProviderServiceCubit>().fetchCatalog();
            }
          },
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
          icon: const Icon(Icons.add),
          label: const Text(
            'Add Service',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<ProviderServiceCubit, ProviderServiceState>(
          listener: (context, state) {
            if (state is ProviderServiceActionSuccess) {
              // 🚀 Using your custom extension for Success!
              context.showSnackBar(state.message, type: SnackBarType.success);
            } else if (state is ProviderServiceFailure) {
              // 🚀 Using your custom extension for Errors!
              context.showSnackBar(
                state.error.message ??
                    'An unexpected error occurred. Please try again.',
                type: SnackBarType.error,
              );
            }
          },
          buildWhen: (previous, current) {
            return current is ProviderServiceLoading ||
                current is ProviderServiceLoaded ||
                current is ProviderServiceFailure;
          },
          builder: (context, state) {
            if (state is ProviderServiceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProviderServiceFailure) {
              // 🎯 Utilizes your global SevikaStatePlaceholder for error
              return SevikaStatePlaceholder(
                icon: Icons.error_outline,
                title: 'Oops! Something went wrong',
                message: state.error.message ?? 'An unexpected error occurred. Please check your connection and try again.',
                iconColor: context.colorScheme.error,
                iconBackgroundColor: context.colorScheme.errorContainer
                    .withValues(alpha: 0.3),
                actionButtonText: 'Try Again',
                actionButtonIcon: Icons.refresh,
                onActionPressed: () =>
                    context.read<ProviderServiceCubit>().fetchCatalog(),
              );
            }

            if (state is ProviderServiceLoaded) {
              final catalog = state.response.catalog;

              // Filter locally based on strict Enums
              final activeServices = catalog
                  .where((s) => s.status == ServiceStatus.approved)
                  .toList();
              final pendingServices = catalog
                  .where((s) => s.status == ServiceStatus.pending)
                  .toList();
              final rejectedServices = catalog
                  .where((s) => s.status == ServiceStatus.rejected)
                  .toList();

              return TabBarView(
                children: [
                  _buildServiceList(catalog),
                  _buildServiceList(activeServices),
                  _buildServiceList(pendingServices),
                  _buildServiceList(rejectedServices),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildServiceList(List<ProviderServiceEntity> services) {
    if (services.isEmpty) {
      // 🎯 Utilizes your global SevikaStatePlaceholder for empty state
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: SevikaStatePlaceholder(
                icon: Icons.design_services_outlined,
                title: 'No services found',
                message: 'You don\'t have any services in this category yet. Add a service to start getting booked.',
                actionButtonText: 'Add Your First Service',
                actionButtonIcon: Icons.add,
                onActionPressed: () async {
                  await Navigator.pushNamed(
                    context,
                    RouteList.addEditServicePage,
                    arguments: ServiceActionArgs(),
                  );

                  if (context.mounted) {
                    context.read<ProviderServiceCubit>().fetchCatalog();
                  }
                },
              ),
            ),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: context.colorScheme.primary,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          top: AppDimensions.paddingL,
          left: AppDimensions.paddingM,
          right: AppDimensions.paddingM,
          bottom: 100,
        ),
        itemCount: services.length,
        separatorBuilder: (_, _) => AppDimensions.gapM,
        itemBuilder: (context, index) {
          return PortfolioServiceCard(service: services[index]);
        },
      ),
    );
  }
}

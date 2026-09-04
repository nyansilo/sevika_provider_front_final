import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/routes/route_list.dart';
import '../widgets/portfolio/portfolio_service_card.dart';

class ServicePortfolioScreen extends StatefulWidget {
  const ServicePortfolioScreen({super.key});

  @override
  State<ServicePortfolioScreen> createState() => _ServicePortfolioScreenState();
}

class _ServicePortfolioScreenState extends State<ServicePortfolioScreen> {
  // 👨‍🔧 Mock Data: Replace with Bloc/Cubit state later
  final List<Map<String, dynamic>> _mockServices = [
    {
      'id': '1',
      'title': 'Deep Move-Out Cleaning (3 Bedrooms)',
      'category': 'Cleaning',
      'price': 'TZS 80,000',
      'status': 'Active', // Approved and live
    },
    {
      'id': '2',
      'title': 'Sofa & Carpet Shampooing',
      'category': 'Cleaning',
      'price': 'TZS 45,000',
      'status': 'Pending', // Waiting for admin
    },
    {
      'id': '3',
      'title': 'Plumbing Inspection & Fix',
      'category': 'Plumbing',
      'price': 'TZS 20,000',
      'status': 'Rejected',
      'feedback': 'Please specify if materials are included in this price.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // All, Active, Pending, Rejected
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
              Tab(text: 'Needs Attention'), // Better UX than saying "Rejected"
            ],
          ),
        ),

        // 🎯 THE FAB
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              Navigator.pushNamed(context, RouteList.addEditServicePage),
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
          icon: const Icon(Icons.add),
          label: const Text(
            'Add Service',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        body: TabBarView(
          children: [
            _buildServiceList(_mockServices), // All
            _buildServiceList(
              _mockServices.where((s) => s['status'] == 'Active').toList(),
            ),
            _buildServiceList(
              _mockServices.where((s) => s['status'] == 'Pending').toList(),
            ),
            _buildServiceList(
              _mockServices.where((s) => s['status'] == 'Rejected').toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceList(List<Map<String, dynamic>> services) {
    if (services.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingL,
        left: AppDimensions.paddingM,
        right: AppDimensions.paddingM,
        bottom: 100, // Clearance for the FAB
      ),
      itemCount: services.length,
      separatorBuilder: (_, _) => AppDimensions.gapM,
      itemBuilder: (context, index) {
        return PortfolioServiceCard(service: services[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingXL),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.design_services_outlined,
                size: 64,
                color: context.colorScheme.primary,
              ),
            ),
            AppDimensions.gapL,
            Text(
              'No services found',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            AppDimensions.gapS,
            Text(
              'You don\'t have any services in this category yet. Add a service to start getting booked by clients.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            AppDimensions.gapL,
            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteList.addEditServicePage),
              icon: const Icon(Icons.add),
              label: const Text('Add Your First Service'),
            ),
          ],
        ),
      ),
    );
  }
}

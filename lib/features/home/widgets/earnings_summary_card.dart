import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class EarningsSummaryCard extends StatelessWidget {
  final String totalBalance;
  final String completedJobs;
  final String rating;
  final String hoursOnline;

  const EarningsSummaryCard({
    super.key,
    required this.totalBalance,
    required this.completedJobs,
    required this.rating,
    required this.hoursOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary,
            context.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Payout Balance',
            style: TextStyle(
              color: Colors.white70,
              fontSize: AppDimensions.fontSizeCaption,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            totalBalance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppDimensions.fontSizeDisplay,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.white24, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEarningStat('Completed Jobs', completedJobs),
              _buildEarningStat('Rating', rating),
              _buildEarningStat('Hours Online', hoursOnline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: AppDimensions.fontSizeCaption,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.fontSizeSubheading,
          ),
        ),
      ],
    );
  }
}

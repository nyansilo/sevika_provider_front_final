import 'package:flutter/material.dart';
import '../../../../../core/constants/app_dimensions.dart';
import 'address_item_skeleton.dart';

class AddressListSkeleton extends StatelessWidget {
  final int itemCount;

  const AddressListSkeleton({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment
          .topCenter, // 👈 Anchors the constrained block safely to the top
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxDashboardWidth,
        ),
        child: ListView.separated(
          // 👈 Removed shrinkWrap: true so it naturally builds down from the top edge
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          itemCount: itemCount,
          separatorBuilder: (context, index) => AppDimensions.gapM,
          itemBuilder: (context, index) {
            return const AddressItemSkeleton();
          },
        ),
      ),
    );
  }
}

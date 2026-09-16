import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_state_placeholder.dart';
import '../../../../core/routes/route_list.dart';

import '../../domain/enums/kyc_status.dart'; // 🛡️ ADDED: To access KycStatus enum
import '../../domain/enums/kyc_tier.dart';
import '../cubits/provider_kyc_cubit.dart';
import '../cubits/provider_kyc_state.dart';
import '../widgets/kyc_tier_card_widget.dart';
import '../widgets/kyc_tier_header_widget.dart';

class KycDashboardScreen extends StatelessWidget {
  const KycDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
        centerTitle: true,
      ),
      body: BlocConsumer<ProviderKycCubit, ProviderKycState>(
        listener: (context, state) {
          if (state is ProviderKycFailure) {
            context.showSnackBar(
              state.error.message ??
                  'Unable to verify status. Please try again.',
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is ProviderKycLoading || state is ProviderKycInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProviderKycLoaded) {
            final kyc = state.kycData;

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<ProviderKycCubit>().fetchKycStatus(),
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  KycTierHeaderWidget(
                    tier: kyc.kycTier,
                    verifiedAt: kyc.verifiedAt,
                  ),
                  AppDimensions.gapXL,

                  // 🟡 TIER 1: BASIC VERIFICATION
                  KycTierCardWidget(
                    title: 'Tier 1: Basic Identity',
                    description: 'Required to accept instant bookings. Needs NIDA & Selfie.',
                    status: kyc.status,
                    isLocked: false,
                    rejectionReason: kyc.rejectionReason,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteList.submitBasicKycPage,
                      arguments: context.read<ProviderKycCubit>(),
                    ),
                  ),
                  AppDimensions.gapL,

                  // 🟢 TIER 2: PROFESSIONAL UPGRADE
                  KycTierCardWidget(
                    title: 'Tier 2: Professional',
                    description: 'Unlocks custom bidding & high-value jobs. Requires Business License.',

                    // 🛡️ DEFENSIVE UI PATCH:
                    // If the backend API mistakenly sends proUpgradeStatus as "approved"
                    // but the global tier is strictly "basic", we force the UI to "unsubmitted"
                    // so the provider can actually click the card and upload their Pro documents!
                    status:
                        (kyc.kycTier == KycTier.basic &&
                            kyc.proUpgradeStatus == KycStatus.approved)
                        ? KycStatus
                              .unsubmitted // *(Note: if your default enum is named .unverified or .none, change it here)*
                        : kyc.proUpgradeStatus,

                    isLocked:
                        kyc.kycTier != KycTier.basic &&
                        kyc.kycTier != KycTier.professional,
                    rejectionReason: kyc.proRejectionReason,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteList.submitProKycPage,
                      arguments: context.read<ProviderKycCubit>(),
                    ),
                  ),
                ],
              ),
            );
          }

          return SevikaStatePlaceholder(
            title: 'Unable to load profile',
            message: 'We could not fetch your verification status. Please check your connection.',
            icon: Icons.wifi_off_rounded,
            actionButtonText: 'Retry',
            onActionPressed: () =>
                context.read<ProviderKycCubit>().fetchKycStatus(),
          );
        },
      ),
    );
  }
}

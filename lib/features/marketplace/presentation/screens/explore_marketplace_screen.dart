import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';
import '../../domain/entities/open_job_request_entity.dart'; // Ensure this matches your file name
import '../../domain/usecases/params/place_bid_params.dart';
import '../cubits/explore_jobs_cubit.dart';
import '../cubits/explore_jobs_state.dart';
import '../cubits/place_bid_cubit.dart';
import '../cubits/place_bid_state.dart';

class ExploreMarketplaceScreen extends StatefulWidget {
  const ExploreMarketplaceScreen({super.key});

  @override
  State<ExploreMarketplaceScreen> createState() =>
      _ExploreMarketplaceScreenState();
}

class _ExploreMarketplaceScreenState extends State<ExploreMarketplaceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExploreJobsCubit>().fetchJobs();
  }

  void _openBidBottomSheet(BuildContext context, OpenJobRequestEntity job) {
    // 🎯 Capture the cubit instance before entering the bottom sheet's context
    final exploreCubit = context.read<ExploreJobsCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to move up with the keyboard
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<PlaceBidCubit>(
        create: (_) => sl<PlaceBidCubit>(),
        child: _PlaceBidBottomSheet(
          job: job,
          onBidSuccess: () {
            // 🔄 Triggers the background refresh when the bid succeeds
            exploreCubit.fetchJobs();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text(
          'Open Marketplace',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ExploreJobsCubit, ExploreJobsState>(
        builder: (context, state) {
          if (state is ExploreJobsLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is ExploreJobsFailure) {
            return Center(
              child: Text(state.error.message ?? 'Failed to load jobs'),
            );
          }
          if (state is ExploreJobsSuccess) {
            if (state.jobs.isEmpty) {
              return const Center(child: Text('No open requests right now.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
                  child: ListTile(
                    title: Text(
                      job.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimensions.paddingXS,
                      ),
                      child: Text(
                        job.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _openBidBottomSheet(context, job),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
/// BOTTOM SHEET WIDGET: Isolated to manage its own form state and controllers
/// ----------------------------------------------------------------------------
class _PlaceBidBottomSheet extends StatefulWidget {
  final OpenJobRequestEntity job;
  final VoidCallback
  onBidSuccess; // 🎯 ADDED: Callback for success coordination

  const _PlaceBidBottomSheet({required this.job, required this.onBidSuccess});

  @override
  State<_PlaceBidBottomSheet> createState() => _PlaceBidBottomSheetState();
}

class _PlaceBidBottomSheetState extends State<_PlaceBidBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _proposalController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _proposalController.dispose();
    super.dispose();
  }

  void _submitBid() {
    context.unfocusKeyboard();

    if (_formKey.currentState!.validate()) {
      final bidAmount = double.parse(_priceController.text.trim());

      context.read<PlaceBidCubit>().submitBid(
        PlaceBidParams(
          jobRequestId: widget.job.jobRequestId,
          bidAmount: bidAmount,
          proposalText: _proposalController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🎯 Wrap in GestureDetector to dismiss keyboard when tapping outside inputs
    return GestureDetector(
      onTap: () => context.unfocusKeyboard(),
      child: Container(
        // Padding for the keyboard to push the sheet up
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusL),
          ),
        ),
        child: BlocConsumer<PlaceBidCubit, PlaceBidState>(
          listener: (context, state) {
            if (state is PlaceBidFailure) {
              context.showSnackBar(
                state.error.message ?? 'Failed to submit your bid.',
                type: SnackBarType.error,
              );
            } else if (state is PlaceBidSuccess) {
              Navigator.pop(context); // Close the Bottom Sheet
              context.showSnackBar(
                'Bid submitted! The client will review your proposal.',
                type: SnackBarType.success,
              );

              // 🔄 BEST PRACTICE: Trigger a refresh on ExploreJobsCubit
              // so the submitted job disappears from the list, preventing double-bids!
              widget.onBidSuccess();
            }
          },
          builder: (context, state) {
            final isLoading = state is PlaceBidLoading;

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: context.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    AppDimensions.gapXL,

                    Text(
                      'Submit Proposal',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDimensions.gapS,
                    Text(
                      'Bidding on: ${widget.job.title}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppDimensions.gapL,
                    // 💰 Price Input
                    TextFormField(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) => (val == null || val.isEmpty)
                          ? 'Please enter a valid price'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Your Bid Price (TSh)',
                        prefixText: 'TSh ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                        ),
                      ),
                    ),
                    AppDimensions.gapXS,
                    // 🚀 ADDED HELPER TEXT FOR THE PROVIDER
                    Text(
                      'This is your base quote. A platform safety fee will be added to this amount for the customer.',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    AppDimensions.gapM,

                    // 📝 Proposal Text Input
                    TextFormField(
                      controller: _proposalController,
                      maxLines: 4,
                      validator: (val) => (val == null || val.trim().isEmpty)
                          ? 'Please explain your offer and why they should choose you'
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Message to Client',
                        alignLabelWithHint: true,
                        hintText: 'I have 5 years of experience in this field. I can start tomorrow...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                        ),
                      ),
                    ),
                    AppDimensions.gapXL,

                    // 🚀 Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: SevikaButton(
                        text: 'Send Proposal',
                        icon: Icons.send_rounded,
                        isLoading: isLoading,
                        onPressed: isLoading ? null : _submitBid,
                      ),
                    ),
                    AppDimensions.gapM,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

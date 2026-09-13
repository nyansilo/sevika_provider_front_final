import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 🎯 ADDED: For BLoC integration

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../../domain/entities/booking_entity.dart';

// 🎯 ADDED: Required imports for the API call
import '../cubits/manage_job/manage_job_cubit.dart';
import '../cubits/manage_job/manage_job_state.dart';
import '../../domain/usecases/params/update_booking_status_params.dart';

class SubmitQuoteScreen extends StatefulWidget {
  final BookingEntity booking;

  const SubmitQuoteScreen({super.key, required this.booking});

  @override
  State<SubmitQuoteScreen> createState() => _SubmitQuoteScreenState();
}

class _SubmitQuoteScreenState extends State<SubmitQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _proposalController = TextEditingController();

  // 🗑️ Removed manual _isLoading bool, we now rely entirely on the BLoC state!

  @override
  void dispose() {
    _priceController.dispose();
    _proposalController.dispose();
    super.dispose();
  }

  void _submitBid() {
    context.unfocusKeyboard();

    if (_formKey.currentState!.validate()) {
      final price = double.parse(_priceController.text.trim());

      // 👨‍🔧 REAL IMPLEMENTATION: Trigger your ManageJobCubit here
      // Passing status: 'quote_provided' and estimatedPrice from the text controller
      context.read<ManageJobCubit>().updateJobStatus(
        UpdateBookingStatusParams(
          bookingReference: widget.booking.bookingReference,
          status: 'quote_provided',
          estimatedPrice: price,
          // Note: If you add proposalText to UpdateBookingStatusParams later,
          // you can pass _proposalController.text here!
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocusKeyboard(),
      // 🎯 WRAPPED: BlocConsumer handles the Loading, Success, and Failure states natively
      child: BlocConsumer<ManageJobCubit, ManageJobState>(
        listener: (context, state) {
          if (state is ManageJobFailure) {
            context.showSnackBar(
              state.error.message ?? 'Failed to submit bid.',
              type: SnackBarType.error,
            );
          } else if (state is ManageJobSuccess) {
            context.showSnackBar(
              'Bid submitted successfully! The client will review your offer.',
              type: SnackBarType.success,
            );
            Navigator.pop(context); // Return to Dashboard
          }
        },
        builder: (context, state) {
          final bool isLoading =
              state is ManageJobLoading; // 🔄 Read loading state from Cubit

          return Scaffold(
            backgroundColor: context.colorScheme.surface,
            appBar: AppBar(
              title: const Text('Submit Bid'),
              centerTitle: true,
              backgroundColor: context.colorScheme.surface,
              elevation: 0,
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Job Summary
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusM,
                        ),
                        border: Border.all(
                          color: context.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Client Request',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppDimensions.gapS,
                          Text(
                            widget.booking.requestedService,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppDimensions.gapXS,
                          Text(
                            widget.booking.specialInstructions ??
                                'No special instructions provided.',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (widget.booking.quoteMetadata?.projectSize !=
                              null) ...[
                            AppDimensions.gapM,
                            Text(
                              'Project Size: ${widget.booking.quoteMetadata!.projectSize.toUpperCase()}',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    AppDimensions.gapXL,

                    // 2. Pricing Input
                    Text(
                      'Your Estimated Price (TSh)',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDimensions.gapS,
                    TextFormField(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) => (val == null || val.isEmpty)
                          ? 'Please enter your bid amount'
                          : null,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        prefixText: 'TSh ',
                        prefixStyle: context.textTheme.headlineSmall?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerLowest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                        ),
                      ),
                    ),
                    AppDimensions.gapXL,

                    // 3. Proposal Text
                    Text(
                      'Message to Client',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDimensions.gapS,
                    TextFormField(
                      controller: _proposalController,
                      maxLines: 4,
                      validator: (val) => (val == null || val.trim().isEmpty)
                          ? 'Provide a brief explanation of your bid'
                          : null,
                      decoration: InputDecoration(
                        hintText: 'Explain what is included in your price, how long it will take, and why they should hire you...',
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerLowest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                        ),
                      ),
                    ),
                    AppDimensions.gapXXXL,

                    // 4. Submit Button
                    SevikaButton(
                      text: 'Submit Bid to Client',
                      icon: Icons.send_rounded,
                      isLoading: isLoading, // 🔄 Uses BLoC state
                      onPressed: isLoading
                          ? null
                          : _submitBid, // 🚫 Prevents double-taps
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

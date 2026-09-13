import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/media_picker_helper.dart';
import '../../domain/enums/kyc_status.dart'; // 🚀 IMPORTED: Required to check if the state is rejected
import '../../domain/usecases/params/submit_basic_kyc_params.dart';
import '../cubits/provider_kyc_cubit.dart';
import '../cubits/provider_kyc_state.dart';
import '../widgets/image_picker_box_widget.dart';

/// 🛡️ Submit Basic KYC Screen (Tier 1)
///
/// This screen collects the provider's NIDA number and biometric data (ID & Selfie).
/// It shares the exact same `ProviderKycCubit` instance as the `KycDashboardScreen`.
/// This means if the provider was previously rejected, this screen instantly knows
/// without needing any `Args` classes passed through the router!
class SubmitBasicKycScreen extends StatefulWidget {
  const SubmitBasicKycScreen({super.key});

  @override
  State<SubmitBasicKycScreen> createState() => _SubmitBasicKycScreenState();
}

class _SubmitBasicKycScreenState extends State<SubmitBasicKycScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nidaController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Local state to hold the file paths before submission
  String? _idFrontPath;
  String? _selfiePath;

  @override
  void dispose() {
    _nidaController.dispose();
    super.dispose();
  }

  /// Handles securely capturing images via the device camera or gallery.

  Future<void> _pickImage(bool isFront) async {
    context.unfocusKeyboard();

    // UX Best Practice: IDs can be uploaded from gallery, but selfies should ideally be live camera
    // Note: You will need to import 'package:image_picker/image_picker.dart' just for the ImageSource enum,
    // or you can abstract the enum into the helper if you want zero coupling.
    final source = isFront ? ImageSource.gallery : ImageSource.camera;

    try {
      // 🚀 THE FIX: Use the centralized helper
      final String? imagePath = await MediaPickerHelper.pickImage(
        source: source,
      );

      if (imagePath != null) {
        setState(() {
          if (isFront) {
            _idFrontPath = imagePath;
          } else {
            _selfiePath = imagePath;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(
          'Failed to access camera/gallery.',
          type: SnackBarType.error,
        );
      }
    }
  }

  /// Validates the form and dispatches the submission event to the shared Cubit.
  void _submit() {
    context.unfocusKeyboard();

    if (_formKey.currentState!.validate()) {
      // 🛑 Defensive Guard: Ensure files are actually selected before hitting the network
      if (_idFrontPath == null || _selfiePath == null) {
        context.showSnackBar(
          'Please provide both your ID Front and a Selfie image.',
          type: SnackBarType.warning,
        );
        return;
      }

      // 🚀 Dispatch to the shared Cubit. Once successful, the Dashboard will automatically update.
      context.read<ProviderKycCubit>().submitBasicKyc(
        SubmitBasicKycParams(
          nidaNumber: _nidaController.text.trim(),
          idFrontPath: _idFrontPath!, // Safe bang operator due to guard above
          selfiePath: _selfiePath!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Verification')),
      body: BlocConsumer<ProviderKycCubit, ProviderKycState>(
        listener: (context, state) {
          // 🟢 Handle Success: Show snackbar and pop back to the dashboard
          if (state is ProviderKycActionSuccess) {
            context.showSnackBar(state.message, type: SnackBarType.success);
            if (Navigator.canPop(context)) Navigator.pop(context);
          }
          // 🔴 Handle Failure: Catch API or Validation errors gracefully
          else if (state is ProviderKycFailure) {
            context.showSnackBar(
              state.error.message ?? 'Submission failed. Please try again.',
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ProviderKycLoading;

          // 🔍 STATE INSPECTION: Check if the provider is currently in a "Rejected" state
          // Because we share the Cubit with the Dashboard, this data is already in memory!
          String? rejectionReason;
          if (state is ProviderKycLoaded &&
              state.kycData.status == KycStatus.rejected) {
            rejectionReason = state.kycData.rejectionReason;
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              children: [
                // ⚠️ DYNAMIC REJECTION BANNER
                // Automatically appears if the compliance team previously rejected their Tier 1 submission
                if (rejectionReason != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    decoration: BoxDecoration(
                      color: context.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: context.colorScheme.error,
                        ),
                        AppDimensions.gapS,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Previous Submission Rejected',
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: context.colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AppDimensions.gapVS,
                              Text(
                                rejectionReason,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppDimensions.gapL,
                ],

                // 📝 INSTRUCTIONS
                Text(
                  'Verify your identity to start accepting jobs.',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppDimensions.gapXL,

                // 💳 NIDA TEXT INPUT
                Text(
                  'NIDA Number',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppDimensions.gapS,
                TextFormField(
                  controller: _nidaController,
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    hintText: 'Enter 20-digit NIDA number',
                    prefixIcon: Icon(Icons.credit_card_rounded),
                  ),
                  // Uses the centralized validation engine ensuring exactly 20 digits
                  validator: AppValidators.validateNida,
                ),
                AppDimensions.gapL,

                // 🖼️ ID FRONT IMAGE PICKER
                ImagePickerBoxWidget(
                  title: 'Upload ID Front',
                  subtitle: 'Clear photo of your physical NIDA card',
                  imagePath: _idFrontPath,
                  icon: Icons.badge_outlined,
                  onTap: () => _pickImage(true),
                ),
                AppDimensions.gapL,

                // 🤳 SELFIE IMAGE PICKER
                ImagePickerBoxWidget(
                  title: 'Take a Selfie',
                  subtitle: 'Match the face on your NIDA card',
                  imagePath: _selfiePath,
                  icon: Icons.face_rounded,
                  onTap: () => _pickImage(false),
                ),
                AppDimensions.gapXXL,

                // 🚀 SUBMIT BUTTON
                SevikaButton(
                  text: 'Submit Verification',
                  isLoading: isLoading,
                  onPressed: _submit,
                  icon: Icons.security_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

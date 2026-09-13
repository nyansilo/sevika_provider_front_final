import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../../../../core/utils/media_picker_helper.dart';
import '../../domain/usecases/params/upgrade_to_pro_params.dart';
import '../cubits/provider_kyc_cubit.dart';
import '../cubits/provider_kyc_state.dart';
import '../widgets/document_picker_widget.dart';

class SubmitProKycScreen extends StatefulWidget {
  const SubmitProKycScreen({super.key});

  @override
  State<SubmitProKycScreen> createState() => _SubmitProKycScreenState();
}

class _SubmitProKycScreenState extends State<SubmitProKycScreen> {
  String? _businessLicensePath;
  String? _businessLicenseName;

  String? _tradeCertificatePath;
  String? _tradeCertificateName;

  String? _policeClearancePath;
  String? _policeClearanceName;

  Future<void> _pickDocument(String docType) async {
    try {
      // 🚀 THE FIX: Use the centralized helper
      final PickedFileMeta? pickedDoc = await MediaPickerHelper.pickDocument();

      if (pickedDoc != null) {
        setState(() {
          if (docType == 'license') {
            _businessLicensePath = pickedDoc.path;
            _businessLicenseName = pickedDoc.name;
          } else if (docType == 'trade') {
            _tradeCertificatePath = pickedDoc.path;
            _tradeCertificateName = pickedDoc.name;
          } else if (docType == 'police') {
            _policeClearancePath = pickedDoc.path;
            _policeClearanceName = pickedDoc.name;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Failed to read file.', type: SnackBarType.error);
      }
    }
  }

  void _submit() {
    if (_businessLicensePath == null) {
      context.showSnackBar(
        'Your Business License is required for Pro tier.',
        type: SnackBarType.warning,
      );
      return;
    }

    context.read<ProviderKycCubit>().submitProUpgrade(
      UpgradeToProParams(
        businessLicensePath: _businessLicensePath!,
        tradeCertificatePath: _tradeCertificatePath,
        policeClearancePath: _policeClearancePath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade to Professional')),
      body: BlocConsumer<ProviderKycCubit, ProviderKycState>(
        listener: (context, state) {
          if (state is ProviderKycActionSuccess) {
            context.showSnackBar(state.message, type: SnackBarType.success);
            if (Navigator.canPop(context)) Navigator.pop(context);
          } else if (state is ProviderKycFailure) {
            context.showSnackBar(
              state.error.message ?? 'Failed to submit documents.',
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ProviderKycLoading;

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: context.colorScheme.secondary,
                    ),
                    AppDimensions.gapS,
                    Expanded(
                      child: Text(
                        'PDF, JPG, or PNG files only (Max 5MB per file).',
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              AppDimensions.gapXL,

              DocumentPickerWidget(
                title: 'Business License',
                isRequired: true,
                filePath: _businessLicensePath,
                fileName: _businessLicenseName,
                onTap: () => _pickDocument('license'),
              ),
              AppDimensions.gapL,

              DocumentPickerWidget(
                title: 'Trade Certificate',
                isRequired: false,
                filePath: _tradeCertificatePath,
                fileName: _tradeCertificateName,
                onTap: () => _pickDocument('trade'),
              ),
              AppDimensions.gapL,

              DocumentPickerWidget(
                title: 'Police Clearance',
                isRequired: false,
                filePath: _policeClearancePath,
                fileName: _policeClearanceName,
                onTap: () => _pickDocument('police'),
              ),
              AppDimensions.gapXXL,

              SevikaButton(
                text: 'Submit Documents',
                isLoading: isLoading,
                onPressed: _submit,
                icon: Icons.upload_file_rounded,
              ),
            ],
          );
        },
      ),
    );
  }
}

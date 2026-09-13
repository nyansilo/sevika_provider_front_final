import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/global/presentation/widgets/brand_logo.dart';
import '../../../../core/global/presentation/widgets/app_text_field.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';

import '../../domain/entities/reset_channel.dart';
import '../../domain/usecases/params/forgot_password_params.dart';
import '../cubits/password_recovery/password_recovery_cubit.dart';
import '../cubits/password_recovery/password_recovery_state.dart.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _contactController = TextEditingController();
  ResetChannel _selectedChannel = ResetChannel.email;

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  void _onSendPressed() {
    final contact = _contactController.text.trim();
    if (contact.isEmpty) return;

    context.read<PasswordRecoveryCubit>().forgotPassword(
      ForgotPasswordParams(
        channel: _selectedChannel,
        email: _selectedChannel == ResetChannel.email ? contact : null,
        phoneNumber: _selectedChannel == ResetChannel.phone ? contact : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocusKeyboard(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pushNamed(
                context,
                RouteList.otpVerificationPage,
                arguments: {
                  'channel': _selectedChannel,
                  'contact': _contactController.text.trim(),
                },
              );
            } else if (state is PasswordRecoveryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error.message ?? "Forgot Password Error Occurred",
                  ),
                  backgroundColor: context.colorScheme.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppDimensions.maxFormContentWidth,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BrandLogo(),
                        AppDimensions.gapXL,

                        Center(
                          child: Text(
                            'Reset Password',
                            style: context.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        AppDimensions.gapS,
                        Text(
                          'Select how you would like to recover your account and enter your details.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppDimensions.gapXL,

                        SegmentedButton<ResetChannel>(
                          segments: const [
                            ButtonSegment(
                              value: ResetChannel.email,
                              label: Text('Email'),
                              icon: Icon(Icons.email_outlined),
                            ),
                            ButtonSegment(
                              value: ResetChannel.phone,
                              label: Text('Phone'),
                              icon: Icon(Icons.phone_outlined),
                            ),
                          ],
                          selected: {_selectedChannel},
                          onSelectionChanged: (Set<ResetChannel> newSelection) {
                            setState(() {
                              _selectedChannel = newSelection.first;
                              _contactController.clear();
                            });
                          },
                        ),
                        AppDimensions.gapL,

                        AppTextField(
                          controller: _contactController,
                          label: _selectedChannel == ResetChannel.email
                              ? 'Email Address'
                              : 'Phone Number',
                          hintText: _selectedChannel == ResetChannel.email
                              ? 'name@example.com'
                              : '+255711223344',
                          prefixIcon: Icon(
                            _selectedChannel == ResetChannel.email
                                ? Icons.email_outlined
                                : Icons.phone_outlined,
                          ),
                          keyboardType: _selectedChannel == ResetChannel.email
                              ? TextInputType.emailAddress
                              : TextInputType.phone,
                        ),
                        AppDimensions.gapXL,

                        SevikaButton(
                          text: state is PasswordRecoveryLoading
                              ? 'Sending...'
                              : 'Send Verification Link',
                          onPressed: state is PasswordRecoveryLoading
                              ? null
                              : _onSendPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

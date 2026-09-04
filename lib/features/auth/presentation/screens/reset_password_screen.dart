import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/presentation/widgets/brand_logo.dart';
import '../../../../core/presentation/widgets/app_text_field.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';

import '../../domain/entities/reset_channel.dart';
import '../../domain/usecases/params/reset_password_params.dart';
import '../cubits/password_recovery/password_recovery_cubit.dart';
import '../cubits/password_recovery/password_recovery_state.dart.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit(ResetChannel channel, String contact, String code) {
    context.read<PasswordRecoveryCubit>().resetPassword(
      ResetPasswordParams(
        channel: channel,
        email: channel == ResetChannel.email ? contact : null,
        phoneNumber: channel == ResetChannel.phone ? contact : null,
        code: code,
        newPassword: _passwordController.text,
        newPasswordConfirmation: _confirmPasswordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final channel = args?['channel'] as ResetChannel? ?? ResetChannel.email;
    final contact = args?['contact'] as String? ?? '';
    final code = args?['code'] as String? ?? '';

    return GestureDetector(
      onTap: () => context.unfocusKeyboard(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteList.loginPage,
                (route) => false,
              );
            } else if (state is PasswordRecoveryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error.message ?? "Reset password error occurred",
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
                            'New Password',
                            style: context.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        AppDimensions.gapS,
                        Center(
                          child: Text(
                            'Create a fresh, unique password to secure your account.',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        AppDimensions.gapXXL,

                        AppTextField(
                          controller: _passwordController,
                          label: 'New Password',
                          hintText: 'Min 8 characters',
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: _isPasswordObscured,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(
                                () =>
                                    _isPasswordObscured = !_isPasswordObscured,
                              );
                            },
                          ),
                        ),
                        AppDimensions.gapM,

                        AppTextField(
                          controller: _confirmPasswordController,
                          label: 'Confirm New Password',
                          hintText: 'Repeat password securely',
                          prefixIcon: const Icon(Icons.lock_clock_outlined),
                          obscureText: _isConfirmPasswordObscured,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(
                                () => _isConfirmPasswordObscured =
                                    !_isConfirmPasswordObscured,
                              );
                            },
                          ),
                        ),
                        AppDimensions.gapXL,

                        SevikaButton(
                          text: state is PasswordRecoveryLoading
                              ? 'Updating...'
                              : 'Update & Sign In',
                          onPressed: state is PasswordRecoveryLoading
                              ? null
                              : () => _onSubmit(channel, contact, code),
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

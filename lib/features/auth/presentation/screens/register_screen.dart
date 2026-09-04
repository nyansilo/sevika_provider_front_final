import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/presentation/widgets/brand_logo.dart';
import '../../../../core/presentation/widgets/app_text_field.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';
import '../../domain/usecases/params/register_params.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      final cleanName = _nameController.text.trim();
      final parts = cleanName.split(RegExp(r'\s+'));

      final firstName = parts.first;
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

      var rawPhone = _phoneController.text.trim();
      if (rawPhone.startsWith('0')) {
        rawPhone = rawPhone.substring(1);
      }

      context.read<AuthCubit>().register(
        RegisterParams(
          firstName: firstName,
          lastName: lastName,
          email: _emailController.text.trim(),
          phoneNumber: rawPhone,
          password: _passwordController.text.trim(),
          confirmPassword: _confirmPasswordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocusKeyboard(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: context.colorScheme.onSurface),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppDimensions.maxFormContentWidth,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BrandLogo(),
                      AppDimensions.gapXL,
                      Center(
                        child: Text(
                          'Create Account',
                          style: context.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AppDimensions.gapS,
                      Center(
                        child: Text(
                          'Join us to book premium home solutions instantly.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      AppDimensions.gapXL,

                      AppTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        hintText: 'John Doe',
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: AppValidators.validateFullName,
                      ),
                      AppDimensions.gapM,

                      AppTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        hintText: 'name@example.com',
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidators.validateEmail,
                      ),
                      AppDimensions.gapM,

                      AppTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        hintText: '712345678',
                        keyboardType: TextInputType.phone,
                        validator: AppValidators.validateTanzanianPhone,
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(
                            right: AppDimensions.paddingS,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingM,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: context.colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                '🇹🇿',
                                style: TextStyle(
                                  fontSize: AppDimensions.size20,
                                ),
                              ),
                              const SizedBox(width: AppDimensions.paddingS),
                              Text(
                                '+255',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppDimensions.gapM,

                      AppTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hintText: 'Create strong password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: _isPasswordObscured,
                        validator: AppValidators.validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () => setState(
                            () => _isPasswordObscured = !_isPasswordObscured,
                          ),
                        ),
                      ),
                      AppDimensions.gapM,

                      AppTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hintText: 'Retype your access password',
                        prefixIcon: const Icon(Icons.lock_clock_outlined),
                        obscureText: _isConfirmPasswordObscured,
                        validator: (value) =>
                            AppValidators.validateConfirmPassword(
                              value,
                              _passwordController.text,
                            ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordObscured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () => setState(
                            () => _isConfirmPasswordObscured =
                                !_isConfirmPasswordObscured,
                          ),
                        ),
                      ),
                      AppDimensions.gapXL,

                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return SevikaButton(
                            text: state is AuthLoading
                                ? 'Creating Account...'
                                : 'Register Account',
                            onPressed: state is AuthLoading
                                ? null
                                : _onRegisterPressed,
                          );
                        },
                      ),
                      AppDimensions.gapL,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

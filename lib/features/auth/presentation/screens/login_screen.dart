import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/global/presentation/widgets/brand_logo.dart';
import '../../../../core/global/presentation/widgets/app_text_field.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../../../../core/global/presentation/widgets/social_login_buttons.dart';

import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/params/login_params.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        LoginParams(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  void _onSocialLogin(SocialProvider provider) {
    context.read<AuthCubit>().socialLogin(provider);
  }

  Future<void> _showEmailDialog(String tempToken, String message) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final String? submittedEmail = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Email', style: context.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(message, style: context.textTheme.bodyMedium),
              const SizedBox(height: 20),
              AppTextField(
                controller: controller,
                label: 'Email Address',
                hintText: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                validator: AppValidators.validateEmail,
              ),
              const SizedBox(height: 20),
              SevikaButton(
                text: 'Continue',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(ctx, controller.text.trim());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );

    if (submittedEmail != null && mounted) {
      context.read<AuthCubit>().completeSocialRegistration(
        tempToken: tempToken,
        email: submittedEmail,
      );
    } else {
      context.read<AuthCubit>().cancelSocialFlow();
    }
  }

  Future<void> _showPasswordDialog(
    String tempToken,
    String email,
    String message,
  ) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final String? submittedPassword = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Link Account', style: context.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(message, style: context.textTheme.bodyMedium),
              const SizedBox(height: 20),
              AppTextField(
                controller: controller,
                label: 'Password for $email',
                hintText: 'Enter your password',
                obscureText: true,
                validator: AppValidators.validatePassword,
              ),
              const SizedBox(height: 20),
              SevikaButton(
                text: 'Verify & Link',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(ctx, controller.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );

    if (submittedPassword != null && mounted) {
      context.read<AuthCubit>().completeSocialRegistration(
        tempToken: tempToken,
        email: email,
        password: submittedPassword,
      );
    } else {
      context.read<AuthCubit>().cancelSocialFlow();
    }
  }

  Future<void> _showPhoneDialog(UserEntity user) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final String? submittedPhone = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Almost done, ${user.firstName}!',
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'We need your phone number so service providers can contact you regarding your bookings.',
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: controller,
                  label: 'Phone Number',
                  hintText: 'e.g., 0712345678',
                  keyboardType: TextInputType.phone,
                  validator: (val) => (val == null || val.isEmpty)
                      ? 'Phone number is required'
                      : null,
                ),
                const SizedBox(height: 20),
                SevikaButton(
                  text: 'Complete Profile',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(ctx, controller.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (submittedPhone != null && mounted) {
      context.read<AuthCubit>().submitPhoneNumber(submittedPhone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocusKeyboard(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              context.showSnackBar(
                state.error.message ?? 'An error occurred',
                type: SnackBarType.error,
              );
            }
            if (state is AuthAuthenticated) {
              Navigator.pushReplacementNamed(context, RouteList.mainPage);
            }
            if (state is AuthRequiresEmail) {
              _showEmailDialog(state.tempToken, state.message);
            }
            if (state is AuthRequiresPassword) {
              _showPasswordDialog(state.tempToken, state.email, state.message);
            }
            if (state is AuthRequiresPhoneNumber) {
              _showPhoneDialog(state.user);
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BrandLogo(),
                          AppDimensions.gapXL,
                          Center(
                            child: Text(
                              'Welcome Back!',
                              style: context.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          AppDimensions.gapS,
                          Text(
                            'Sign in to access your dashboard and active bookings.',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          AppDimensions.gapXL,

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
                            controller: _passwordController,
                            label: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            obscureText: _isPasswordObscured,
                            validator: AppValidators.validatePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(
                                () =>
                                    _isPasswordObscured = !_isPasswordObscured,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                RouteList.forgotPasswordPage,
                              ),
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          AppDimensions.gapL,

                          SevikaButton(
                            text: state is AuthLoading
                                ? 'Signing In...'
                                : 'Sign In',
                            onPressed: state is AuthLoading
                                ? null
                                : _onSignInPressed,
                          ),

                          AppDimensions.gapXL,

                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: context.colorScheme.outlineVariant,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimensions.paddingM,
                                ),
                                child: Text(
                                  'Or sign in with',
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        color: context.colorScheme.outline,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: context.colorScheme.outlineVariant,
                                ),
                              ),
                            ],
                          ),
                          AppDimensions.gapL,

                          SocialLoginButtons(
                            onGoogleTap: () =>
                                _onSocialLogin(SocialProvider.google),
                            onFacebookTap: () =>
                                _onSocialLogin(SocialProvider.facebook),
                            onAppleTap: () =>
                                _onSocialLogin(SocialProvider.apple),
                          ),
                          AppDimensions.gapXL,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  RouteList.registerPage,
                                ),
                                child: const Text('Register'),
                              ),
                            ],
                          ),
                        ],
                      ),
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

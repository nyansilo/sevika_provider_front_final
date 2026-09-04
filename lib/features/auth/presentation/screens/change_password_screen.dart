// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../widgets/change_password/password_input_field.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _handlePasswordUpdate() {
//     if (_formKey.currentState!.validate()) {
//       // Form fields verified successfully—dispatch configuration payload to backend state engine
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) =>
//             const Center(child: CircularProgressIndicator.adaptive()),
//       );

//       Future.delayed(const Duration(seconds: 2), () {
//         if (mounted) {
//           Navigator.pop(context); // Dismiss loader safely

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Password updated successfully!'),
//               backgroundColor: Colors.green,
//             ),
//           );
//           Navigator.pop(context); // Return back to Settings Container
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: theme.colorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Change Password',
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: AppDimensions.maxDashboardWidth,
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(AppDimensions.paddingM),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           PasswordInputField(
//                             controller: _currentPasswordController,
//                             labelText: 'Current Password',
//                             hintText: 'Enter current account password',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your current password';
//                               }
//                               return null;
//                             },
//                           ),
//                           AppDimensions.gapL,
//                           PasswordInputField(
//                             controller: _newPasswordController,
//                             labelText: 'New Password',
//                             hintText: 'Enter new secure password',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter a new password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters long';
//                               }
//                               return null;
//                             },
//                           ),
//                           AppDimensions.gapL,
//                           PasswordInputField(
//                             controller: _confirmPasswordController,
//                             labelText: 'Confirm New Password',
//                             hintText: 'Re-enter new secure password',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please confirm your new password';
//                               }
//                               if (value != _newPasswordController.text) {
//                                 return 'Passwords do not match';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Bottom Sticky Update Action Anchor Box
//                 Container(
//                   padding: const EdgeInsets.all(AppDimensions.paddingM),
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.surface,
//                     border: Border(
//                       top: BorderSide(
//                         color: theme.colorScheme.outlineVariant,
//                         width: 0.5,
//                       ),
//                     ),
//                   ),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: FilledButton(
//                       onPressed: _handlePasswordUpdate,
//                       style: FilledButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: AppDimensions.paddingM,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                             AppDimensions.radiusM,
//                           ),
//                         ),
//                       ),
//                       child: Text(
//                         'Update Password',
//                         style: theme.textTheme.labelLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: theme.colorScheme.onPrimary,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../widgets/change_password/password_input_field.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _handlePasswordUpdate() {
//     if (_formKey.currentState!.validate()) {
//       // Dismiss the keyboard using your custom extension
//       context.unfocusKeyboard();

//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) =>
//             const Center(child: CircularProgressIndicator.adaptive()),
//       );

//       Future.delayed(const Duration(seconds: 2), () {
//         if (mounted) {
//           Navigator.pop(context); // Dismiss loader safely

//           // Replaced with your new SnackBar extension method
//           context.showSnackBar(
//             'Password updated successfully!',
//             type: SnackBarType.success,
//           );

//           Navigator.pop(context); // Return back to Settings Container
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: context.colorScheme.surface,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Change Password',
//           style: context.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: AppDimensions.maxDashboardWidth,
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(AppDimensions.paddingM),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           PasswordInputField(
//                             controller: _currentPasswordController,
//                             labelText: 'Current Password',
//                             hintText: 'Enter current account password',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your current password';
//                               }
//                               return null;
//                             },
//                           ),
//                           AppDimensions.gapL,
//                           PasswordInputField(
//                             controller: _newPasswordController,
//                             labelText: 'New Password',
//                             hintText: 'Enter new secure password',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter a new password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters long';
//                               }
//                               return null;
//                             },
//                           ),
//                           AppDimensions.gapL,
//                           PasswordInputField(
//                             controller: _confirmPasswordController,
//                             labelText: 'Confirm New Password',
//                             hintText: 'Re-enter new secure password',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please confirm your new password';
//                               }
//                               if (value != _newPasswordController.text) {
//                                 return 'Passwords do not match';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Bottom Sticky Update Action Anchor Box
//                 Container(
//                   padding: const EdgeInsets.all(AppDimensions.paddingM),
//                   decoration: BoxDecoration(
//                     color: context.colorScheme.surface,
//                     border: Border(
//                       top: BorderSide(
//                         color: context.colorScheme.outlineVariant,
//                         width: 0.5,
//                       ),
//                     ),
//                   ),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: FilledButton(
//                       onPressed: _handlePasswordUpdate,
//                       style: FilledButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: AppDimensions.paddingM,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                             AppDimensions.radiusM,
//                           ),
//                         ),
//                       ),
//                       child: Text(
//                         'Update Password',
//                         style: context.textTheme.labelLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: context.colorScheme.onPrimary,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/utils/app_validators.dart';
// import '../../domain/usecases/params/change_password_params.dart';
// import '../cubits/auth/auth_cubit.dart';
// import '../cubits/auth/auth_state.dart';
// import '../widgets/change_password/password_input_field.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _handlePasswordUpdate() {
//     if (_formKey.currentState!.validate()) {
//       context.unfocusKeyboard();

//       // 🚀 FIXED: Instantiated ChangePasswordParams inline to match use-case criteria
//       context.read<AuthCubit>().changePassword(
//         ChangePasswordParams(
//           currentPassword: _currentPasswordController.text,
//           newPassword: _newPasswordController.text,
//           newPasswordConfirmation: _confirmPasswordController.text,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthCubit, AuthState>(
//       // Listen for changes specifically relative to successful operations to handle view routing
//       listenWhen: (previous, current) {
//         if (current is AuthAuthenticated && previous is AuthAuthenticated) {
//           return current.successMessage != previous.successMessage &&
//               current.successMessage != null;
//         }
//         return false;
//       },
//       listener: (context, state) {
//         // Pop the password alteration screen when a success parameter is verified
//         // Note: The snackbar flash message is managed cleanly at the root level by GlobalAppListener
//         Navigator.pop(context);
//       },
//       child: Scaffold(
//         backgroundColor: context.colorScheme.surface,
//         appBar: AppBar(
//           backgroundColor: context.colorScheme.surface,
//           elevation: 0,
//           scrolledUnderElevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: Text(
//             'Change Password',
//             style: context.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: AppDimensions.maxDashboardWidth,
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(AppDimensions.paddingM),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             PasswordInputField(
//                               controller: _currentPasswordController,
//                               labelText: 'Current Password',
//                               hintText: 'Enter current account password',
//                               validator: AppValidators.validatePassword,
//                             ),
//                             AppDimensions.gapL,
//                             PasswordInputField(
//                               controller: _newPasswordController,
//                               labelText: 'New Password',
//                               hintText: 'Enter new secure password',
//                               validator: AppValidators.validatePassword,
//                             ),
//                             AppDimensions.gapL,
//                             PasswordInputField(
//                               controller: _confirmPasswordController,
//                               labelText: 'Confirm New Password',
//                               hintText: 'Re-enter new secure password',
//                               validator: (value) =>
//                                   AppValidators.validateConfirmPassword(
//                                     value,
//                                     _newPasswordController.text,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                   // Bottom Sticky Update Action Anchor Box
//                   Container(
//                     padding: const EdgeInsets.all(AppDimensions.paddingM),
//                     decoration: BoxDecoration(
//                       color: context.colorScheme.surface,
//                       border: Border(
//                         top: BorderSide(
//                           color: context.colorScheme.outlineVariant,
//                           width: 0.5,
//                         ),
//                       ),
//                     ),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: BlocBuilder<AuthCubit, AuthState>(
//                         builder: (context, state) {
//                           // Adapt based on state implementation. Assuming a loading flag or explicit state check.
//                           final isLoading =
//                               state is AuthLoading ||
//                               (state is AuthAuthenticated &&
//                                   state.isLoading == true);

//                           return FilledButton(
//                             onPressed: isLoading ? null : _handlePasswordUpdate,
//                             style: FilledButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: AppDimensions.paddingM,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   AppDimensions.radiusM,
//                                 ),
//                               ),
//                             ),
//                             child: isLoading
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator.adaptive(
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : Text(
//                                     'Update Password',
//                                     style: context.textTheme.labelLarge
//                                         ?.copyWith(
//                                           fontWeight: FontWeight.bold,
//                                           color: context.colorScheme.onPrimary,
//                                         ),
//                                   ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/app_validators.dart';
import '../../domain/usecases/params/change_password_params.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../widgets/change_password/password_input_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handlePasswordUpdate() {
    if (_formKey.currentState!.validate()) {
      context.unfocusKeyboard();

      context.read<AuthCubit>().changePassword(
        ChangePasswordParams(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
          newPasswordConfirmation: _confirmPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        if (current is AuthAuthenticated && previous is AuthAuthenticated) {
          return current.successMessage != previous.successMessage &&
              current.successMessage != null;
        }
        return false;
      },
      listener: (context, state) {
        Navigator.pop(context);
      },
      // 🎯 UX FIX: Added GestureDetector to dismiss keyboard on background tap
      child: GestureDetector(
        onTap: () => context.unfocusKeyboard(),
        child: Scaffold(
          backgroundColor: context.colorScheme.surface,
          appBar: AppBar(
            backgroundColor: context.colorScheme.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Change Password',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.maxDashboardWidth,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppDimensions.paddingM),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PasswordInputField(
                                controller: _currentPasswordController,
                                labelText: 'Current Password',
                                hintText: 'Enter current account password',
                                validator: AppValidators.validatePassword,
                              ),
                              AppDimensions.gapL,
                              PasswordInputField(
                                controller: _newPasswordController,
                                labelText: 'New Password',
                                hintText: 'Enter new secure password',
                                validator: AppValidators.validatePassword,
                              ),
                              AppDimensions.gapL,
                              PasswordInputField(
                                controller: _confirmPasswordController,
                                labelText: 'Confirm New Password',
                                hintText: 'Re-enter new secure password',
                                validator: (value) =>
                                    AppValidators.validateConfirmPassword(
                                      value,
                                      _newPasswordController.text,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bottom Sticky Update Action Anchor Box
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        border: Border(
                          top: BorderSide(
                            color: context.colorScheme.outlineVariant,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            final isLoading =
                                state is AuthLoading ||
                                (state is AuthAuthenticated &&
                                    state.isLoading == true);

                            return FilledButton(
                              onPressed: isLoading
                                  ? null
                                  : _handlePasswordUpdate,
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppDimensions.paddingM,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusM,
                                  ),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Update Password',
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                context.colorScheme.onPrimary,
                                          ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

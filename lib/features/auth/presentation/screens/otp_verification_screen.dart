import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/presentation/widgets/brand_logo.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';
import '../../domain/entities/reset_channel.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<String> _otpDigits = List.filled(6, '');

  void _onVerifyPressed(ResetChannel channel, String contact) {
    final code = _otpDigits.join();
    if (code.length < 6) return;

    Navigator.pushNamed(
      context,
      RouteList.resetPasswordPage,
      arguments: {'channel': channel, 'contact': contact, 'code': code},
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final channel = args?['channel'] as ResetChannel? ?? ResetChannel.email;
    final contact = args?['contact'] as String? ?? '';

    return GestureDetector(
      onTap: () => context.unfocusKeyboard(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: SafeArea(
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
                        'Verify OTP',
                        style: context.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AppDimensions.gapS,
                    Center(
                      child: Text(
                        'We sent a 6-digit code to $contact. Enter it below.',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppDimensions.gapXXL,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor:
                                  context.colorScheme.surfaceContainerLow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusL,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusL,
                                ),
                                borderSide: BorderSide(
                                  color: context.colorScheme.primary,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              _otpDigits[index] = value;
                              if (value.length == 1 && index < 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    AppDimensions.gapXXL,
                    SevikaButton(
                      text: 'Verify Code',
                      onPressed: () => _onVerifyPressed(channel, contact),
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

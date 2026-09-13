import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/animation_constants.dart';
import '../../../../core/routes/route_list.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';
import '../cubits/onboarding/onboarding_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isExiting = false;

  // 👨‍🔧 PROVIDER ONBOARDING MESSAGING
  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Be Your Own Boss',
      'subtitle': 'Set your own schedule, choose the jobs you want, and work on your own terms.',
      'icon': '💼',
    },
    {
      'title': 'Grow Your Earnings',
      'subtitle': 'Access hundreds of local job requests daily. Get paid quickly and securely.',
      'icon': '💸',
    },
    {
      'title': 'Manage with Ease',
      'subtitle': 'Track your active jobs, communicate with clients, and manage your portfolio all in one app.',
      'icon': '📱',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() async {
    if (_isExiting) return;

    setState(() => _isExiting = true);

    await context.read<OnboardingCubit>().completeOnboarding();

    if (mounted) {
      Navigator.pushReplacementNamed(context, RouteList.welcomePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == _onboardingData.length - 1;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxOnboardingWidth,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: AppDimensions.paddingM,
                      top: AppDimensions.paddingS,
                    ),
                    child: TextButton(
                      onPressed: _isExiting ? null : _finishOnboarding,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: _isExiting
                              ? context.colorScheme.outline
                              : context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: _isExiting
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingXL,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _onboardingData[index]['icon']!,
                              style: TextStyle(
                                fontSize: context.screenHeight * 0.08,
                              ),
                            ),
                            SizedBox(height: context.screenHeight * 0.04),
                            Text(
                              _onboardingData[index]['title']!,
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            AppDimensions.gapM,
                            Text(
                              _onboardingData[index]['subtitle']!,
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingXL),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          _onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: AnimationConstants.durationFast,
                            curve: AnimationConstants.curveDefaultEntrance,
                            margin: const EdgeInsets.only(
                              right: AppDimensions.paddingS,
                            ),
                            height: AppDimensions.paddingS,
                            width: _currentPage == index
                                ? AppDimensions.size24
                                : AppDimensions.size8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? context.colorScheme.primary
                                  : context.colorScheme.outlineVariant,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusS,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: isLastPage ? 165.0 : AppDimensions.size110,
                        child: SevikaButton(
                          text: isLastPage ? 'Get Started' : 'Next',
                          icon: _isExiting ? null : Icons.arrow_forward_rounded,
                          onPressed: _isExiting
                              ? null
                              : () {
                                  if (isLastPage) {
                                    _finishOnboarding();
                                  } else {
                                    _pageController.nextPage(
                                      duration: AnimationConstants.durationFast,
                                      curve: AnimationConstants
                                          .curveDefaultEntrance,
                                    );
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

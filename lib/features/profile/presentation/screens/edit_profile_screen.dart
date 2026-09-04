import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart'; // 🎯 l10n is here
import '../../../../core/presentation/widgets/app_circle_avatar.dart';
import '../../../../core/presentation/widgets/app_text_field.dart';
import '../../domain/usecases/params/update_profile_params.dart';
import '../cubits/profile/profile_cubit.dart';
import '../cubits/profile/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _altPhoneController;

  io.File? _selectedImageFile;

  @override
  void initState() {
    super.initState();

    final profileState = context.read<ProfileCubit>().state;

    String initialFirstName = '';
    String initialLastName = '';
    String initialPhone = '';
    String initialEmail = '';
    String initialAddress = '';
    String initialCity = '';
    String initialAltPhone = '';

    if (profileState is ProfileLoaded) {
      final user = profileState.profile.userBase;
      final extra = profileState.profile.providerProfile;

      initialFirstName = user.firstName;
      initialLastName = user.lastName;
      initialPhone = user.phoneNumber;
      initialEmail = user.email;
      initialAddress = extra?.defaultAddress ?? '';
      initialCity = extra?.city ?? '';
      initialAltPhone = extra?.alternativePhone ?? '';
    }

    _firstNameController = TextEditingController(text: initialFirstName);
    _lastNameController = TextEditingController(text: initialLastName);
    _phoneController = TextEditingController(text: initialPhone);
    _emailController = TextEditingController(text: initialEmail);
    _addressController = TextEditingController(text: initialAddress);
    _cityController = TextEditingController(text: initialCity);
    _altPhoneController = TextEditingController(text: initialAltPhone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _altPhoneController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    // 🎯 Cache l10n before the async gap
    final l10n = context.l10n;

    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 500,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImageFile = io.File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(
          l10n.errorChoosingImage, // 🎯 Localized
          type: SnackBarType.error,
        );
      }
    }
  }

  Future<void> _saveProfileChanges() async {
    // 🎯 UX FIX: Instantly drop the device keyboard when the user taps save
    // so it doesn't cover up the success SnackBar!
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) return;

    final params = UpdateProfileParams(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      defaultAddress: _addressController.text.trim(),
      city: _cityController.text.trim(),
      alternativePhone: _altPhoneController.text.trim().isEmpty
          ? null
          : _altPhoneController.text.trim(),
      imageFile: _selectedImageFile,
    );

    await context.read<ProfileCubit>().updateProfile(params);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileCubit>().state;
    // 🎯 Cache the localization instance for the entire build method
    final l10n = context.l10n;

    String remoteImageUrl = '';
    bool isSubmitting = false;

    if (profileState is ProfileLoaded) {
      remoteImageUrl = profileState.profile.userBase.profileImage;
      isSubmitting = profileState.isUpdating;
    }

    // 🎯 UX FIX: Wrap Scaffold in GestureDetector so tapping anywhere outside a text field hides the keyboard
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: context.colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.colorScheme.onSurface,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            l10n.editProfileSettings, // 🎯 Localized
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              current is ProfileLoaded || current is ProfileFailure,
          listener: (context, state) {
            if (state is ProfileLoaded) {
              if (state.successMessage != null) {
                context.showSnackBar(
                  state.successMessage!,
                  type: SnackBarType.success,
                );
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
              if (state.error != null) {
                context.showSnackBar(
                  state.error!.message ??
                      l10n.failedToUpdateProfile, // 🎯 Localized
                  type: SnackBarType.error,
                );
              }
            }
            if (state is ProfileFailure) {
              context.showSnackBar(
                state.error.message ?? l10n.unexpectedError, // 🎯 Localized
                type: SnackBarType.error,
              );
            }
          },
          child: SafeArea(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppDimensions.gapM,

                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  if (_selectedImageFile != null)
                                    CircleAvatar(
                                      radius: AppDimensions.avatarRadiusL + 12,
                                      backgroundImage: FileImage(
                                        _selectedImageFile!,
                                      ),
                                    )
                                  else
                                    AppCircleAvatar(
                                      radius: AppDimensions.avatarRadiusL + 12,
                                      imageUrl: remoteImageUrl.isNotEmpty
                                          ? remoteImageUrl
                                          : '',
                                    ),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor:
                                        context.colorScheme.primary,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 16,
                                        color: context.colorScheme.onPrimary,
                                      ),
                                      onPressed: isSubmitting
                                          ? null
                                          : _pickProfileImage,
                                    ),
                                  ),
                                ],
                              ),

                              AppDimensions.gapXL,

                              Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                      label: l10n.firstName, // 🎯 Localized
                                      hintText: l10n.firstName,
                                      controller: _firstNameController,
                                      prefixIcon: const Icon(
                                        Icons.person_outline_rounded,
                                        size: 20,
                                      ),
                                      validator: (val) =>
                                          val == null || val.trim().isEmpty
                                          ? l10n
                                                .requiredField // 🎯 Localized
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: AppDimensions.paddingS),
                                  Expanded(
                                    child: AppTextField(
                                      label: l10n.lastName, // 🎯 Localized
                                      hintText: l10n.lastName,
                                      controller: _lastNameController,
                                      prefixIcon: const Icon(
                                        Icons.person_outline_rounded,
                                        size: 20,
                                      ),
                                      validator: (val) =>
                                          val == null || val.trim().isEmpty
                                          ? l10n
                                                .requiredField // 🎯 Localized
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              AppDimensions.gapM,

                              AppTextField(
                                label: l10n.defaultAddress, // 🎯 Localized
                                hintText:
                                    l10n.enterStreetAddress, // 🎯 Localized
                                controller: _addressController,
                                prefixIcon: const Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                ),
                                validator: (val) =>
                                    val == null || val.trim().isEmpty
                                    ? l10n
                                          .addressRequired // 🎯 Localized
                                    : null,
                              ),
                              AppDimensions.gapM,

                              AppTextField(
                                label: l10n.city, // 🎯 Localized
                                hintText: l10n.cityHint, // 🎯 Localized
                                controller: _cityController,
                                prefixIcon: const Icon(
                                  Icons.location_city_rounded,
                                  size: 20,
                                ),
                                validator: (val) =>
                                    val == null || val.trim().isEmpty
                                    ? l10n
                                          .cityRequired // 🎯 Localized
                                    : null,
                              ),
                              AppDimensions.gapM,

                              AppTextField(
                                label: l10n.alternativePhone, // 🎯 Localized
                                hintText:
                                    l10n.secondaryContactNumber, // 🎯 Localized
                                controller: _altPhoneController,
                                prefixIcon: const Icon(
                                  Icons.phone_android_rounded,
                                  size: 20,
                                ),
                              ),
                              AppDimensions.gapM,

                              AbsorbPointer(
                                absorbing: true,
                                child: AppTextField(
                                  label:
                                      l10n.primaryPhoneLocked, // 🎯 Localized
                                  hintText: '',
                                  controller: _phoneController,
                                  prefixIcon: const Icon(
                                    Icons.phone_android_rounded,
                                    size: 20,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: context.colorScheme.outline,
                                    size: 18,
                                  ),
                                ),
                              ),
                              AppDimensions.gapM,

                              AbsorbPointer(
                                absorbing: true,
                                child: AppTextField(
                                  label:
                                      l10n.emailAddressLocked, // 🎯 Localized
                                  hintText: '',
                                  controller: _emailController,
                                  prefixIcon: const Icon(
                                    Icons.mail_outline_rounded,
                                    size: 20,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: context.colorScheme.outline,
                                    size: 18,
                                  ),
                                ),
                              ),
                              AppDimensions.gapXL,
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        border: Border(
                          top: BorderSide(
                            color: context.colorScheme.outlineVariant
                                .withValues(alpha: 0.5),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: isSubmitting ? null : _saveProfileChanges,
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
                          child: isSubmitting
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                )
                              : Text(
                                  l10n.saveProfileChanges, // 🎯 Localized
                                  style: context.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.onPrimary,
                                  ),
                                ),
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

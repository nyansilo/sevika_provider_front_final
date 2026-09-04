import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';
import '../../../../core/presentation/widgets/app_empty_state_placeholder.dart';

import '../../domain/usecases/params/address_payload_params.dart';
import '../cubits/customer_address/customer_address_cubit.dart';
import '../cubits/customer_address/customer_address_state.dart';
import '../widgets/address_card.dart';
import '../widgets/address_form.dart';
import '../widgets/shimmers/address_list_skeleton.dart';

class SavedAddressScreen extends StatefulWidget {
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  @override
  void initState() {
    super.initState();
    // 🎯 FIXED: Wait for the router to finish mounting the BlocProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CustomerAddressCubit>().loadAddresses();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final bool isPickerMode = routeArgs?['is_picker_mode'] == true;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: context.colorScheme.onSurface,
            size: AppDimensions.iconM,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isPickerMode ? 'Select Delivery Location' : 'Saved Addresses',
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
            child: BlocConsumer<CustomerAddressCubit, CustomerAddressState>(
              listener: (context, state) {
                if (state is CustomerAddressActionSuccess) {
                  context.showSnackBar(
                    state.message,
                    type: SnackBarType.success,
                  );
                }
              },
              buildWhen: (previous, current) =>
                  current is CustomerAddressLoading ||
                  current is CustomerAddressLoaded ||
                  current is CustomerAddressError,
              builder: (context, state) {
                final bool isScreenLoading =
                    state is CustomerAddressLoading ||
                    state is CustomerAddressInitial;
                final addresses = state is CustomerAddressLoaded
                    ? state.addresses
                    : [];

                return Column(
                  children: [
                    Expanded(
                      child: isScreenLoading
                          ? const AddressListSkeleton(itemCount: 3)
                          : addresses.isEmpty
                          ? const AppEmptyStatePlaceholder(
                              icon: Icons.map_outlined,
                              message: 'No saved destinations yet.',
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(
                                AppDimensions.paddingM,
                              ),
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                final currentAddress = addresses[index];

                                final dynamicLines = [
                                  currentAddress.addressLine1,
                                  if (currentAddress.addressLine2 != null &&
                                      currentAddress.addressLine2!.isNotEmpty)
                                    currentAddress.addressLine2,
                                  '${currentAddress.districtName}, ${currentAddress.regionName}',
                                ].join(', ');

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppDimensions.paddingM,
                                  ),
                                  child: AddressCard(
                                    address: currentAddress,
                                    label: currentAddress.label,
                                    fullAddress: dynamicLines,
                                    icon: _determineIconFor(
                                      currentAddress.label,
                                    ),
                                    isDefault: currentAddress.isDefault,
                                    onSetDefault: () {
                                      context
                                          .read<CustomerAddressCubit>()
                                          .editAddress(
                                            addressId: currentAddress.addressId,
                                            params: AddressPayloadParams(
                                              label: currentAddress.label,
                                              addressLine1:
                                                  currentAddress.addressLine1,
                                              addressLine2:
                                                  currentAddress.addressLine2,
                                              regionId: currentAddress.regionId,
                                              districtId:
                                                  currentAddress.districtId,
                                              country: 'Tanzania',
                                              isDefault: true,
                                            ),
                                          );
                                    },
                                    onDeleteSuccess: () {
                                      context
                                          .read<CustomerAddressCubit>()
                                          .removeAddress(
                                            currentAddress.addressId,
                                          );
                                    },
                                    onTap: () {
                                      if (isPickerMode) {
                                        Navigator.pop(context, {
                                          'id': currentAddress.addressId,
                                          'address_line_1':
                                              currentAddress.addressLine1,
                                          'address_line_2':
                                              currentAddress.addressLine2,
                                          'region_id': currentAddress.regionId,
                                          'region_name':
                                              currentAddress.regionName,
                                          'district_id':
                                              currentAddress.districtId,
                                          'district_name':
                                              currentAddress.districtName,
                                        });
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                              value: context
                                                  .read<CustomerAddressCubit>(),
                                              child: AddressForm(
                                                isEdit: true,
                                                address: currentAddress,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
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
                            width: AppDimensions.navBorderThin,
                          ),
                        ),
                      ),
                      child: SevikaButton(
                        text: 'Add New Address',
                        icon: Icons.add_location_alt_rounded,
                        isLoading: state is CustomerAddressSubmitting,
                        onPressed: isScreenLoading
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: context
                                          .read<CustomerAddressCubit>(),
                                      child: const AddressForm(isEdit: false),
                                    ),
                                  ),
                                );
                              },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  IconData _determineIconFor(String label) {
    final lower = label.toLowerCase();
    if (lower.contains('home')) return Icons.home_rounded;
    if (lower.contains('work') ||
        lower.contains('office') ||
        lower.contains('cbe')) {
      return Icons.business_rounded;
    }
    return Icons.location_on_rounded;
  }
}

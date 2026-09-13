import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/app_field_lebel.dart';
import '../../../../core/global/presentation/widgets/app_text_field.dart';
import '../../../shared/location/presentation/cubits/location/location_cubit.dart';
import '../../../shared/location/presentation/cubits/location/location_state.dart';
import '../../domain/entities/customer_address_entity.dart';
import '../../domain/usecases/params/address_payload_params.dart';
import '../cubits/customer_address/customer_address_cubit.dart';
import 'address_preset_selector.dart';

class AddressForm extends StatefulWidget {
  final bool isEdit;
  final CustomerAddressEntity? address;

  const AddressForm({super.key, required this.isEdit, this.address});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _labelController;
  late TextEditingController _addressController;
  late TextEditingController _notesController;

  String _selectedType = 'Home';
  bool _isDefaultAddress = false;

  // 🎯 REAL TIME SELECTION CONTEXTS
  int? _selectedRegionId;
  int? _selectedDistrictId;

  @override
  void initState() {
    super.initState();

    _labelController = TextEditingController(
      text: widget.isEdit ? (widget.address?.label ?? '') : '',
    );
    _addressController = TextEditingController(
      text: widget.isEdit ? (widget.address?.addressLine1 ?? '') : '',
    );
    _notesController = TextEditingController(
      text: widget.isEdit ? (widget.address?.addressLine2 ?? '') : '',
    );

    if (widget.isEdit && widget.address != null) {
      _selectedRegionId = widget.address!.regionId;
      _selectedDistrictId = widget.address!.districtId;
      _isDefaultAddress = widget.address!.isDefault;

      final label = widget.address!.label;
      if (['Home', 'Work', 'Office'].contains(label)) {
        _selectedType = label;
      } else {
        _selectedType = 'Custom';
      }
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          widget.isEdit ? 'Edit Address' : 'Add New Address',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, locationState) {
            if (locationState is LocationLoading ||
                locationState is LocationInitial) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (locationState is LocationError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  child: Text(
                    locationState.message,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (locationState is LocationLoaded) {
              // 1️⃣ Hydrate safe initial defaults based on lazy repository states
              _selectedRegionId ??= widget.isEdit
                  ? widget.address!.regionId
                  : locationState.regions.firstOrNull?.id;

              final currentDistricts = locationState.districts
                  .where((d) => d.regionId == _selectedRegionId)
                  .toList();

              // Safeguard selection tracking parameters if the region tree changes completely
              if (_selectedDistrictId == null ||
                  !currentDistricts.any((d) => d.id == _selectedDistrictId)) {
                _selectedDistrictId = currentDistricts.firstOrNull?.id;
              }

              return Center(
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
                                const AppFieldLabel(
                                  text: 'Address Label Preset',
                                ),
                                AppDimensions.gapXS,
                                AddressPresetSelector(
                                  selectedType: _selectedType,
                                  onSelected: (type) {
                                    setState(() {
                                      _selectedType = type;
                                      if (type != 'Custom') {
                                        _labelController.text = type;
                                      } else if (!widget.isEdit) {
                                        _labelController.clear();
                                      }
                                    });
                                  },
                                ),
                                AppDimensions.gapM,

                                if (_selectedType == 'Custom') ...[
                                  const AppFieldLabel(
                                    text: 'Custom Label Name',
                                  ),
                                  AppDimensions.gapXS,
                                  AppTextField(
                                    controller: _labelController,
                                    hintText:
                                        'e.g., Studio, Gym, Brother\'s House',
                                    prefixIcon: const Icon(
                                      Icons.bookmark_border_rounded,
                                    ),
                                    validator: (val) =>
                                        val == null || val.isEmpty
                                        ? 'Specify label name'
                                        : null,
                                  ),
                                  AppDimensions.gapM,
                                ],

                                AppTextField(
                                  label:
                                      'Street Address / Building / Apartment',
                                  controller: _addressController,
                                  maxLines: 2,
                                  hintText: 'e.g., Samora Avenue, NHC House, 3rd Floor',
                                  prefixIcon: const Icon(
                                    Icons.location_on_outlined,
                                  ),
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'Address detail is required'
                                      : null,
                                ),
                                AppDimensions.gapM,

                                // 🏛️ DYNAMIC REGION SELECTOR
                                const AppFieldLabel(text: 'Region'),
                                AppDimensions.gapXS,
                                DropdownButtonFormField<int>(
                                  initialValue: _selectedRegionId,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.map_outlined),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusM,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppDimensions.paddingM,
                                    ),
                                  ),
                                  items: locationState.regions.map((r) {
                                    return DropdownMenuItem<int>(
                                      value: r.id,
                                      child: Text(r.name),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() {
                                        _selectedRegionId = val;
                                        _selectedDistrictId = null; // Forces recalculation of sub-district context
                                      });
                                    }
                                  },
                                ),
                                AppDimensions.gapM,

                                // 🏘️ DYNAMIC DISTRICT SELECTOR
                                const AppFieldLabel(text: 'District'),
                                AppDimensions.gapXS,
                                DropdownButtonFormField<int>(
                                  initialValue: _selectedDistrictId,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.holiday_village_outlined,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusM,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppDimensions.paddingM,
                                    ),
                                  ),
                                  items: currentDistricts.map((d) {
                                    return DropdownMenuItem<int>(
                                      value: d.id,
                                      child: Text(d.name),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() => _selectedDistrictId = val);
                                    }
                                  },
                                ),
                                AppDimensions.gapM,

                                const AppFieldLabel(
                                  text: 'Delivery Instructions / Drop-off Notes (Optional)',
                                ),
                                AppDimensions.gapXS,
                                AppTextField(
                                  controller: _notesController,
                                  maxLines: 3,
                                  hintText: 'e.g., Near Magomeni Mapipa Bus Rapid Transit Station...',
                                  prefixIcon: const Icon(
                                    Icons.description_outlined,
                                  ),
                                ),
                                AppDimensions.gapL,

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.paddingM,
                                    vertical: AppDimensions.paddingS,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        context.colorScheme.surfaceContainerLow,
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusM,
                                    ),
                                    border: Border.all(
                                      color: context.colorScheme.outlineVariant
                                          .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Set as default address',
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Use as primary checkout location',
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: context
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Switch.adaptive(
                                        value: _isDefaultAddress,
                                        onChanged: (bool value) => setState(
                                          () => _isDefaultAddress = value,
                                        ),
                                        activeThumbColor:
                                            context.colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                AppDimensions.gapXL,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // SUBMIT BUTTON PIPELINE
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.paddingM),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          border: Border(
                            top: BorderSide(
                              color: context.colorScheme.outlineVariant
                                  .withValues(alpha: 0.5),
                              width: AppDimensions.borderWidthThin,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _selectedRegionId != null &&
                                  _selectedDistrictId != null) {
                                final params = AddressPayloadParams(
                                  label: _selectedType == 'Custom'
                                      ? _labelController.text
                                      : _selectedType,
                                  addressLine1: _addressController.text,
                                  addressLine2: _notesController.text.isNotEmpty
                                      ? _notesController.text
                                      : null,
                                  regionId: _selectedRegionId!,
                                  districtId: _selectedDistrictId!,
                                  isDefault: _isDefaultAddress,
                                  country: 'Tanzania',
                                );

                                if (widget.isEdit && widget.address != null) {
                                  context
                                      .read<CustomerAddressCubit>()
                                      .editAddress(
                                        addressId: widget.address!.addressId,
                                        params: params,
                                      );
                                } else {
                                  context
                                      .read<CustomerAddressCubit>()
                                      .registerAddress(params);
                                }
                                // Note: Navigator pop handling is now delegated reactively to the global listener interceptor on mutation success
                              }
                            },
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
                            child: Text(
                              widget.isEdit
                                  ? 'Save Changes'
                                  : 'Save Address Destination',
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
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

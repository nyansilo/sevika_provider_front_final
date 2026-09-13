// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constants/app_dimensions.dart';
// import '../../../../core/extensions/build_context_extensions.dart';
// import '../../../../core/global/presentation/widgets/sevika_alert_dialog.dart';
// import '../../../../core/global/presentation/widgets/sevika_button.dart';

// import '../../../../core/utils/app_validators.dart';

// import '../../../categories/domain/entities/service_category_entity.dart';
// import '../../../categories/presentation/cubits/service_category_cubit.dart';
// import '../../../categories/presentation/cubits/service_category_state.dart';
// import '../../domain/enums/service_status.dart';
// import '../../domain/usecases/params/propose_service_params.dart';
// import '../../domain/usecases/params/update_offering_params.dart';
// import '../args/service_action_args.dart';
// import '../cubits/provider_service_cubit.dart';
// import '../cubits/provider_service_state.dart';

// import '../widgets/add/custom_form_field.dart';
// import '../widgets/add/price_type_selector.dart';
// import 'category_picker_screen.dart';

// class AddEditServiceScreen extends StatefulWidget {
//   final ServiceActionArgs args;

//   const AddEditServiceScreen({super.key, required this.args});

//   @override
//   State<AddEditServiceScreen> createState() => _AddEditServiceScreenState();
// }

// class _AddEditServiceScreenState extends State<AddEditServiceScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Core Form Controllers
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _priceController = TextEditingController();

//   // Controllers for the missing API fields
//   final _estimatedDurationController = TextEditingController();
//   final _inclusionsController = TextEditingController();
//   final _exclusionsController = TextEditingController();

//   // Form State Variables
//   String? _selectedCategoryName;
//   int? _selectedCategoryId;
//   String _selectedPriceType = 'fixed';
//   String _fulfillmentType = 'home';
//   bool _supportsInstantBooking = true;

//   bool get isEditing => widget.args.service != null;

//   // 🚀 SMART LOGIC: Check if the service is officially approved by the admin
//   bool get isApproved => widget.args.service?.status == ServiceStatus.approved;

//   @override
//   void initState() {
//     super.initState();
//     _populateFormIfEditing();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ServiceCategoryCubit>().loadServiceCategories();
//     });
//   }

//   void _populateFormIfEditing() {
//     final service = widget.args.service;
//     if (service != null) {
//       _titleController.text = service.title;
//       _descriptionController.text = service.description;
//       _priceController.text = service.visitFee.toStringAsFixed(0);
//       _selectedPriceType = service.pricingType;
//       _selectedCategoryId = service.categoryId;

//       // Note: Map these if your entity supports them in the future
//       // _estimatedDurationController.text = service.estimatedDuration ?? '';
//       // _fulfillmentType = service.fulfillmentType ?? 'home';
//       // _supportsInstantBooking = service.supportsInstantBooking ?? true;
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _priceController.dispose();
//     _estimatedDurationController.dispose();
//     _inclusionsController.dispose();
//     _exclusionsController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickCategory(
//     BuildContext context,
//     List<ServiceCategoryEntity> categories,
//   ) async {
//     context.unfocusKeyboard();

//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CategoryPickerScreen(
//           categories: categories,
//           selectedCategoryName: _selectedCategoryName,
//         ),
//       ),
//     );

//     if (result != null && result is ServiceCategoryEntity) {
//       setState(() {
//         _selectedCategoryName = result.name;
//         _selectedCategoryId = result.categoryId;
//       });
//     }
//   }

//   String _getBackendPricingType(String uiType) {
//     final type = uiType.toLowerCase();
//     if (type.contains('hour')) return 'hourly';
//     if (type.contains('inspect')) return 'inspection_required';
//     return 'fixed';
//   }

//   List<String> _parseCommaSeparatedList(String text) {
//     if (text.trim().isEmpty) return [];
//     return text
//         .split(',')
//         .map((e) => e.trim())
//         .where((e) => e.isNotEmpty)
//         .toList();
//   }

//   void _submitForm() {
//     context.unfocusKeyboard();

//     if (!_formKey.currentState!.validate()) {
//       context.showSnackBar(
//         'Please fix the errors in the form.',
//         type: SnackBarType.error,
//       );
//       return;
//     }

//     if (_selectedCategoryId == null && !isEditing) {
//       context.showSnackBar(
//         'Please select a category.',
//         type: SnackBarType.error,
//       );
//       return;
//     }

//     final cubit = context.read<ProviderServiceCubit>();

//     if (isEditing) {
//       final params = UpdateOfferingParams(
//         serviceId: widget.args.service!.serviceId,

//         // 🚀 SMART PAYLOAD: If approved, we send NULL so Laravel ignores these fields.
//         // If pending/rejected, we send the updated text!
//         title: isApproved ? null : _titleController.text.trim(),
//         description: isApproved ? null : _descriptionController.text.trim(),
//         categoryId: isApproved ? null : _selectedCategoryId,
//         pricingType: isApproved
//             ? null
//             : _getBackendPricingType(_selectedPriceType),
//         fulfillmentType: isApproved ? null : _fulfillmentType,
//         estimatedDuration: isApproved
//             ? null
//             : _estimatedDurationController.text.trim(),
//         supportsInstantBooking: isApproved ? null : _supportsInstantBooking,
//         inclusions: isApproved
//             ? null
//             : _parseCommaSeparatedList(_inclusionsController.text),
//         exclusions: isApproved
//             ? null
//             : _parseCommaSeparatedList(_exclusionsController.text),

//         // 💸 PRICE & ACTIVE STATUS: Always sent, because they can always be updated!
//         visitFee: double.parse(_priceController.text.replaceAll(',', '')),
//         isActive: widget.args.service!.isActive, // 🚀 PREVENTS THE 422 ERROR!
//       );
//       cubit.updateService(params);
//     } else {
//       final params = ProposeServiceParams(
//         title: _titleController.text.trim(),
//         description: _descriptionController.text.trim(),
//         categoryId: _selectedCategoryId!,
//         pricingType: _getBackendPricingType(_selectedPriceType),
//         fulfillmentType: _fulfillmentType,
//         estimatedDuration: _estimatedDurationController.text.trim(),
//         supportsInstantBooking: _supportsInstantBooking,
//         visitFee: double.parse(_priceController.text.replaceAll(',', '')),
//         inclusions: _parseCommaSeparatedList(_inclusionsController.text),
//         exclusions: _parseCommaSeparatedList(_exclusionsController.text),
//       );
//       cubit.proposeService(params);
//     }
//   }

//   void _confirmDelete() {
//     context.unfocusKeyboard();
//     showSevikaAlertDialog(
//       context: context,
//       icon: Icons.delete_forever_outlined,
//       title: 'Delete Service',
//       content: 'Are you sure you want to permanently delete this service offering? This action cannot be undone.',
//       primaryActionText: 'Delete',
//       isDestructive: true,
//       primaryIsFilled: true,
//       secondaryActionText: 'Cancel',
//       onPrimaryAction: () {
//         Navigator.pop(context);
//         context.read<ProviderServiceCubit>().removeService(
//           widget.args.service!.serviceId,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ProviderServiceCubit, ProviderServiceState>(
//       listener: (context, state) {
//         if (state is ProviderServiceActionSuccess) {
//           context.showSnackBar(
//             isEditing
//                 ? 'Service updated successfully!'
//                 : 'Service submitted for approval.',
//             type: SnackBarType.success,
//           );
//           Navigator.pop(context);
//         } else if (state is ProviderServiceFailure) {
//           context.showSnackBar(
//             state.error.message ??
//                 'An error occurred. Please check your inputs.',
//             type: SnackBarType.error,
//           );
//         }
//       },
//       child: GestureDetector(
//         onTap: () => context.unfocusKeyboard(),
//         child: Scaffold(
//           backgroundColor: context.colorScheme.surface,
//           appBar: AppBar(
//             title: Text(isEditing ? 'Edit Service' : 'Add New Service'),
//             centerTitle: true,
//             backgroundColor: context.colorScheme.surface,
//             elevation: 0,
//           ),
//           body: SafeArea(
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(AppDimensions.paddingM),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ==========================================
//                     // SECTION 1: CATEGORY & TITLE
//                     // ==========================================
//                     Text(
//                       'Category',
//                       style: context.textTheme.titleSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: context.colorScheme.onSurface,
//                       ),
//                     ),
//                     AppDimensions.gapXS,
//                     BlocBuilder<ServiceCategoryCubit, ServiceCategoryState>(
//                       builder: (context, categoryState) {
//                         final isLoadingCategories =
//                             categoryState is ServiceCategoryLoading ||
//                             categoryState is ServiceCategoryInitial;

//                         List<ServiceCategoryEntity> realCategories = [];

//                         if (categoryState is ServiceCategoryLoadSuccess) {
//                           realCategories = categoryState.categories;

//                           if (isEditing &&
//                               _selectedCategoryId != null &&
//                               _selectedCategoryName == null) {
//                             try {
//                               _selectedCategoryName = realCategories
//                                   .firstWhere(
//                                     (c) => c.categoryId == _selectedCategoryId,
//                                   )
//                                   .name;
//                             } catch (_) {
//                               _selectedCategoryName = 'Unknown Category';
//                             }
//                           }
//                         }

//                         return InkWell(
//                           // 🚀 SMART LOGIC: Locks the category picker if already approved
//                           onTap:
//                               (isApproved ||
//                                   isLoadingCategories ||
//                                   realCategories.isEmpty)
//                               ? null
//                               : () => _pickCategory(context, realCategories),
//                           borderRadius: BorderRadius.circular(
//                             AppDimensions.radiusM,
//                           ),
//                           child: InputDecorator(
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(
//                                   AppDimensions.radiusM,
//                                 ),
//                               ),
//                               enabled: !isApproved, // 🚀 SMART LOGIC
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 16,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     isLoadingCategories
//                                         ? 'Loading categories...'
//                                         : (_selectedCategoryName ??
//                                               'Select a category...'),
//                                     style: TextStyle(
//                                       color: _selectedCategoryName == null
//                                           ? context.colorScheme.onSurfaceVariant
//                                           : context.colorScheme.onSurface,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 if (isLoadingCategories)
//                                   const SizedBox(
//                                     width: 16,
//                                     height: 16,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 else
//                                   Icon(
//                                     Icons.arrow_drop_down_rounded,
//                                     color: context.colorScheme.onSurfaceVariant,
//                                   ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     AppDimensions.gapL,

//                     CustomFormField(
//                       label: 'Service Title',
//                       hint: 'e.g. Advanced Generator Repair',
//                       controller: _titleController,
//                       enabled: !isApproved, // 🚀 SMART LOGIC
//                       validator: (val) {
//                         final reqCheck = AppValidators.validateRequiredField(
//                           val,
//                           'Service title is required',
//                         );
//                         if (reqCheck != null) return reqCheck;
//                         if (val!.trim().length < 5) {
//                           return 'Title must be at least 5 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     if (isApproved) ...[
//                       AppDimensions.gapXS,
//                       Text(
//                         'This service is approved. Core details like Title and Category cannot be changed.',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: context.colorScheme.onSurfaceVariant,
//                         ),
//                       ),
//                     ],
//                     AppDimensions.gapL,

//                     // ==========================================
//                     // SECTION 2: PRICING & FULFILLMENT
//                     // ==========================================
//                     PriceTypeSelector(
//                       selectedType: _selectedPriceType,
//                       onChanged: isApproved
//                           ? (val) {}
//                           : (val) => setState(() => _selectedPriceType = val),
//                     ),
//                     AppDimensions.gapM,

//                     // 💸 PRICE IS ALWAYS ENABLED (Providers need to adjust their rates!)
//                     CustomFormField(
//                       label: 'Base Visit Fee',
//                       hint: '45,000',
//                       prefixText: 'TZS ',
//                       controller: _priceController,
//                       enabled: true,
//                       keyboardType: const TextInputType.numberWithOptions(
//                         decimal: true,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(
//                           RegExp(r'^\d+\.?\d{0,2}'),
//                         ),
//                       ],
//                       validator: AppValidators.validateAmount,
//                     ),
//                     AppDimensions.gapL,

//                     Text(
//                       'Location Preference',
//                       style: context.textTheme.titleSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: context.colorScheme.onSurface,
//                       ),
//                     ),
//                     AppDimensions.gapXS,
//                     DropdownButtonFormField<String>(
//                       value: _fulfillmentType,
//                       icon: Icon(
//                         Icons.arrow_drop_down_rounded,
//                         color: context.colorScheme.onSurfaceVariant,
//                       ),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: context.colorScheme.surfaceContainerLowest,
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 16,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(
//                             AppDimensions.radiusM,
//                           ),
//                           borderSide: BorderSide(
//                             color: context.colorScheme.outlineVariant,
//                           ),
//                         ),
//                         enabled: !isApproved, // 🚀 SMART LOGIC
//                       ),
//                       items: const [
//                         DropdownMenuItem(
//                           value: 'home',
//                           child: Text('Home Service (Travel to Client)'),
//                         ),
//                         DropdownMenuItem(
//                           value: 'storefront',
//                           child: Text('Storefront (Client comes to you)'),
//                         ),
//                         DropdownMenuItem(
//                           value: 'dual',
//                           child: Text('Dual (Both available)'),
//                         ),
//                       ],
//                       onChanged: isApproved
//                           ? null
//                           : (val) => setState(() => _fulfillmentType = val!),
//                     ),
//                     AppDimensions.gapL,

//                     // ==========================================
//                     // SECTION 3: DETAILS & SCOPE
//                     // ==========================================
//                     CustomFormField(
//                       label: 'Estimated Duration',
//                       hint: 'e.g. 2-3 hrs',
//                       controller: _estimatedDurationController,
//                       enabled: !isApproved, // 🚀 SMART LOGIC
//                       validator: (val) => AppValidators.validateRequiredField(
//                         val,
//                         'Estimated duration is required',
//                       ),
//                     ),
//                     AppDimensions.gapL,

//                     CustomFormField(
//                       label: 'Description',
//                       hint: 'Complete diagnostic and repair for industrial backup generators...',
//                       controller: _descriptionController,
//                       maxLines: 4,
//                       enabled: !isApproved, // 🚀 SMART LOGIC
//                       validator: (val) => AppValidators.validateRequiredField(
//                         val,
//                         'Description is required',
//                       ),
//                     ),
//                     AppDimensions.gapL,

//                     CustomFormField(
//                       label: 'What is included? (Optional)',
//                       hint: 'Diagnostic, Oil change, Filter replacement',
//                       controller: _inclusionsController,
//                       maxLines: 2,
//                       enabled: !isApproved, // 🚀 SMART LOGIC
//                     ),
//                     AppDimensions.gapXS,
//                     Text(
//                       'Separate each item with a comma',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: context.colorScheme.onSurfaceVariant,
//                       ),
//                     ),
//                     AppDimensions.gapL,

//                     CustomFormField(
//                       label: 'What is NOT included? (Optional)',
//                       hint: 'Replacement parts, Major overhauls',
//                       controller: _exclusionsController,
//                       maxLines: 2,
//                       enabled: !isApproved, // 🚀 SMART LOGIC
//                     ),
//                     AppDimensions.gapL,

//                     SwitchListTile(
//                       title: const Text(
//                         'Allow Instant Booking',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: const Text(
//                         'Clients can book this service instantly without manual approval.',
//                       ),
//                       value: _supportsInstantBooking,
//                       activeColor: context.colorScheme.primary,
//                       contentPadding: EdgeInsets.zero,
//                       onChanged: isApproved
//                           ? null
//                           : (val) =>
//                                 setState(() => _supportsInstantBooking = val),
//                     ),
//                     AppDimensions.gapXXL,

//                     // ==========================================
//                     // SECTION 4: ACTIONS
//                     // ==========================================
//                     BlocBuilder<ProviderServiceCubit, ProviderServiceState>(
//                       builder: (context, state) {
//                         final isLoading = state is ProviderServiceLoading;

//                         return Column(
//                           children: [
//                             SevikaButton(
//                               text: isEditing
//                                   ? 'Save Changes'
//                                   : 'Submit for Approval',
//                               icon: Icons.check_circle_outline,
//                               isLoading: isLoading,
//                               onPressed: _submitForm,
//                             ),
//                             if (isEditing) ...[
//                               AppDimensions.gapM,
//                               SevikaButton(
//                                 text: 'Delete Service',
//                                 isOutlined: true,
//                                 isDestructive: true,
//                                 icon: Icons.delete_outline,
//                                 isLoading: isLoading,
//                                 onPressed: _confirmDelete,
//                               ),
//                             ],
//                           ],
//                         );
//                       },
//                     ),
//                     AppDimensions.gapXXXL,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_alert_dialog.dart';
import '../../../../core/global/presentation/widgets/sevika_button.dart';

import '../../../../core/utils/app_validators.dart';

import '../../../categories/domain/entities/service_category_entity.dart';
import '../../../categories/presentation/cubits/service_category_cubit.dart';
import '../../../categories/presentation/cubits/service_category_state.dart';
import '../../domain/enums/service_status.dart';
import '../../domain/usecases/params/propose_service_params.dart';
import '../../domain/usecases/params/update_offering_params.dart';
import '../args/service_action_args.dart';
import '../cubits/provider_service_cubit.dart';
import '../cubits/provider_service_state.dart';

import '../widgets/add/custom_form_field.dart';
import '../widgets/add/price_type_selector.dart';
import 'category_picker_screen.dart';

class AddEditServiceScreen extends StatefulWidget {
  final ServiceActionArgs args;

  const AddEditServiceScreen({super.key, required this.args});

  @override
  State<AddEditServiceScreen> createState() => _AddEditServiceScreenState();
}

class _AddEditServiceScreenState extends State<AddEditServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Action Tracker
  bool _isDeleting = false; // 🚀 ADDED to separate loading states

  // Core Form Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  // Controllers for the missing API fields
  final _estimatedDurationController = TextEditingController();
  final _inclusionsController = TextEditingController();
  final _exclusionsController = TextEditingController();

  // Form State Variables
  String? _selectedCategoryName;
  int? _selectedCategoryId;
  String _selectedPriceType = 'fixed';
  String _fulfillmentType = 'home';
  bool _supportsInstantBooking = true;

  bool get isEditing => widget.args.service != null;

  // 🚀 SMART LOGIC: Check if the service is officially approved by the admin
  bool get isApproved => widget.args.service?.status == ServiceStatus.approved;

  @override
  void initState() {
    super.initState();
    _populateFormIfEditing();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceCategoryCubit>().loadServiceCategories();
    });
  }

  void _populateFormIfEditing() {
    final service = widget.args.service;
    if (service != null) {
      _titleController.text = service.title;
      _descriptionController.text = service.description;
      _priceController.text = service.visitFee.toStringAsFixed(0);
      _selectedPriceType = service.pricingType;
      _selectedCategoryId = service.categoryId;

      // 🚀 NOW FULLY SUPPORTED AND UNCOMMENTED!
      _estimatedDurationController.text = service.estimatedDuration ?? '';
      _fulfillmentType = service.fulfillmentType;
      _supportsInstantBooking = service.supportsInstantBooking;

      // 🚀 Bonus: Populate inclusions/exclusions arrays back into comma-separated text!
      _inclusionsController.text = service.inclusions.join(', ');
      _exclusionsController.text = service.exclusions.join(', ');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _estimatedDurationController.dispose();
    _inclusionsController.dispose();
    _exclusionsController.dispose();
    super.dispose();
  }

  Future<void> _pickCategory(
    BuildContext context,
    List<ServiceCategoryEntity> categories,
  ) async {
    context.unfocusKeyboard();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPickerScreen(
          categories: categories,
          selectedCategoryName: _selectedCategoryName,
        ),
      ),
    );

    if (result != null && result is ServiceCategoryEntity) {
      setState(() {
        _selectedCategoryName = result.name;
        _selectedCategoryId = result.categoryId;
      });
    }
  }

  String _getBackendPricingType(String uiType) {
    final type = uiType.toLowerCase();
    if (type.contains('hour')) return 'hourly';
    if (type.contains('inspect')) return 'inspection_required';
    return 'fixed';
  }

  List<String> _parseCommaSeparatedList(String text) {
    if (text.trim().isEmpty) return [];
    return text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  void _submitForm() {
    context.unfocusKeyboard();

    if (!_formKey.currentState!.validate()) {
      context.showSnackBar(
        'Please fix the errors in the form.',
        type: SnackBarType.error,
      );
      return;
    }

    if (_selectedCategoryId == null && !isEditing) {
      context.showSnackBar(
        'Please select a category.',
        type: SnackBarType.error,
      );
      return;
    }

    setState(() => _isDeleting = false); // 🚀 We are saving, not deleting
    final cubit = context.read<ProviderServiceCubit>();

    if (isEditing) {
      final params = UpdateOfferingParams(
        serviceId: widget.args.service!.serviceId,

        // 🚀 SMART PAYLOAD: If approved, we send NULL so Laravel ignores these fields.
        // If pending/rejected, we send the updated text!
        title: isApproved ? null : _titleController.text.trim(),
        description: isApproved ? null : _descriptionController.text.trim(),
        categoryId: isApproved ? null : _selectedCategoryId,
        pricingType: isApproved
            ? null
            : _getBackendPricingType(_selectedPriceType),
        fulfillmentType: isApproved ? null : _fulfillmentType,
        estimatedDuration: isApproved
            ? null
            : _estimatedDurationController.text.trim(),
        supportsInstantBooking: isApproved ? null : _supportsInstantBooking,
        inclusions: isApproved
            ? null
            : _parseCommaSeparatedList(_inclusionsController.text),
        exclusions: isApproved
            ? null
            : _parseCommaSeparatedList(_exclusionsController.text),

        // 💸 PRICE & ACTIVE STATUS: Always sent, because they can always be updated!
        visitFee: double.parse(_priceController.text.replaceAll(',', '')),
        isActive: widget.args.service!.isActive, // 🚀 PREVENTS THE 422 ERROR!
      );
      cubit.updateService(params);
    } else {
      final params = ProposeServiceParams(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        categoryId: _selectedCategoryId!,
        pricingType: _getBackendPricingType(_selectedPriceType),
        fulfillmentType: _fulfillmentType,
        estimatedDuration: _estimatedDurationController.text.trim(),
        supportsInstantBooking: _supportsInstantBooking,
        visitFee: double.parse(_priceController.text.replaceAll(',', '')),
        inclusions: _parseCommaSeparatedList(_inclusionsController.text),
        exclusions: _parseCommaSeparatedList(_exclusionsController.text),
      );
      cubit.proposeService(params);
    }
  }

  void _confirmDelete() {
    context.unfocusKeyboard();
    showSevikaAlertDialog(
      context: context,
      icon: Icons.delete_forever_outlined,
      title: 'Delete Service',
      content: 'Are you sure you want to permanently delete this service offering? This action cannot be undone.',
      primaryActionText: 'Delete',
      isDestructive: true,
      primaryIsFilled: true,
      secondaryActionText: 'Cancel',
      onPrimaryAction: () {
        Navigator.pop(context);
        setState(() => _isDeleting = true); // 🚀 We are deleting!
        context.read<ProviderServiceCubit>().removeService(
          widget.args.service!.serviceId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProviderServiceCubit, ProviderServiceState>(
      listener: (context, state) {
        if (state is ProviderServiceActionSuccess) {
          context.showSnackBar(
            isEditing
                ? 'Service updated successfully!'
                : 'Service submitted for approval.',
            type: SnackBarType.success,
          );
          Navigator.pop(context);
        } else if (state is ProviderServiceFailure) {
          context.showSnackBar(
            state.error.message ??
                'An error occurred. Please check your inputs.',
            type: SnackBarType.error,
          );
        }
      },
      child: GestureDetector(
        onTap: () => context.unfocusKeyboard(),
        child: Scaffold(
          backgroundColor: context.colorScheme.surface,
          appBar: AppBar(
            title: Text(isEditing ? 'Edit Service' : 'Add New Service'),
            centerTitle: true,
            backgroundColor: context.colorScheme.surface,
            elevation: 0,
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // SECTION 1: CATEGORY & TITLE
                    // ==========================================
                    Text(
                      'Category',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    AppDimensions.gapXS,
                    BlocBuilder<ServiceCategoryCubit, ServiceCategoryState>(
                      builder: (context, categoryState) {
                        final isLoadingCategories =
                            categoryState is ServiceCategoryLoading ||
                            categoryState is ServiceCategoryInitial;

                        List<ServiceCategoryEntity> realCategories = [];

                        if (categoryState is ServiceCategoryLoadSuccess) {
                          realCategories = categoryState.categories;

                          if (isEditing &&
                              _selectedCategoryId != null &&
                              _selectedCategoryName == null) {
                            try {
                              _selectedCategoryName = realCategories
                                  .firstWhere(
                                    (c) => c.categoryId == _selectedCategoryId,
                                  )
                                  .name;
                            } catch (_) {
                              _selectedCategoryName = 'Unknown Category';
                            }
                          }
                        }

                        return InkWell(
                          // 🚀 SMART LOGIC: Locks the category picker if already approved
                          onTap:
                              (isApproved ||
                                  isLoadingCategories ||
                                  realCategories.isEmpty)
                              ? null
                              : () => _pickCategory(context, realCategories),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusM,
                                ),
                              ),
                              enabled: !isApproved, // 🚀 SMART LOGIC
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    isLoadingCategories
                                        ? 'Loading categories...'
                                        : (_selectedCategoryName ??
                                              'Select a category...'),
                                    style: TextStyle(
                                      color: _selectedCategoryName == null
                                          ? context.colorScheme.onSurfaceVariant
                                          : context.colorScheme.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isLoadingCategories)
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                else
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    AppDimensions.gapL,

                    CustomFormField(
                      label: 'Service Title',
                      hint: 'e.g. Advanced Generator Repair',
                      controller: _titleController,
                      enabled: !isApproved, // 🚀 SMART LOGIC
                      validator: (val) {
                        final reqCheck = AppValidators.validateRequiredField(
                          val,
                          'Service title is required',
                        );
                        if (reqCheck != null) return reqCheck;
                        if (val!.trim().length < 5) {
                          return 'Title must be at least 5 characters long';
                        }
                        return null;
                      },
                    ),
                    if (isApproved) ...[
                      AppDimensions.gapXS,
                      Text(
                        'This service is approved. Core details like Title and Category cannot be changed.',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    AppDimensions.gapL,

                    // ==========================================
                    // SECTION 2: PRICING & FULFILLMENT
                    // ==========================================
                    // Note: Price selector is locked if approved (backend usually requires standard enums)
                    PriceTypeSelector(
                      selectedType: _selectedPriceType,
                      onChanged: isApproved
                          ? (val) {}
                          : (val) => setState(() => _selectedPriceType = val),
                    ),
                    AppDimensions.gapM,

                    // 💸 PRICE IS ALWAYS ENABLED (Providers need to adjust their rates!)
                    CustomFormField(
                      label: 'Base Visit Fee',
                      hint: '45,000',
                      prefixText: 'TZS ',
                      controller: _priceController,
                      enabled: true,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      validator: AppValidators.validateAmount,
                    ),
                    AppDimensions.gapL,

                    Text(
                      'Location Preference',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    AppDimensions.gapXS,
                    DropdownButtonFormField<String>(
                      initialValue: _fulfillmentType,
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerLowest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                          borderSide: BorderSide(
                            color: context.colorScheme.outlineVariant,
                          ),
                        ),
                        enabled: !isApproved, // 🚀 SMART LOGIC
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'home',
                          child: Text('Home Service (Travel to Client)'),
                        ),
                        DropdownMenuItem(
                          value: 'storefront',
                          child: Text('Storefront (Client comes to you)'),
                        ),
                        DropdownMenuItem(
                          value: 'dual',
                          child: Text('Dual (Both available)'),
                        ),
                      ],
                      onChanged: isApproved
                          ? null
                          : (val) => setState(() => _fulfillmentType = val!),
                    ),
                    AppDimensions.gapL,

                    // ==========================================
                    // SECTION 3: DETAILS & SCOPE
                    // ==========================================
                    CustomFormField(
                      label: 'Estimated Duration',
                      hint: 'e.g. 2-3 hrs',
                      controller: _estimatedDurationController,
                      enabled: !isApproved, // 🚀 SMART LOGIC
                      validator: (val) => AppValidators.validateRequiredField(
                        val,
                        'Estimated duration is required',
                      ),
                    ),
                    AppDimensions.gapL,

                    CustomFormField(
                      label: 'Description',
                      hint: 'Complete diagnostic and repair for industrial backup generators...',
                      controller: _descriptionController,
                      maxLines: 4,
                      enabled: !isApproved, // 🚀 SMART LOGIC
                      validator: (val) => AppValidators.validateRequiredField(
                        val,
                        'Description is required',
                      ),
                    ),
                    AppDimensions.gapL,

                    CustomFormField(
                      label: 'What is included? (Optional)',
                      hint: 'Diagnostic, Oil change, Filter replacement',
                      controller: _inclusionsController,
                      maxLines: 2,
                      enabled: !isApproved, // 🚀 SMART LOGIC
                    ),
                    AppDimensions.gapXS,
                    Text(
                      'Separate each item with a comma',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppDimensions.gapL,

                    CustomFormField(
                      label: 'What is NOT included? (Optional)',
                      hint: 'Replacement parts, Major overhauls',
                      controller: _exclusionsController,
                      maxLines: 2,
                      enabled: !isApproved, // 🚀 SMART LOGIC
                    ),
                    AppDimensions.gapL,

                    SwitchListTile(
                      title: const Text(
                        'Allow Instant Booking',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'Clients can book this service instantly without manual approval.',
                      ),
                      value: _supportsInstantBooking,
                      activeThumbColor: context.colorScheme.primary,
                      contentPadding: EdgeInsets.zero,
                      onChanged: isApproved
                          ? null
                          : (val) =>
                                setState(() => _supportsInstantBooking = val),
                    ),
                    AppDimensions.gapXXL,

                    // ==========================================
                    // SECTION 4: ACTIONS
                    // ==========================================
                    BlocBuilder<ProviderServiceCubit, ProviderServiceState>(
                      builder: (context, state) {
                        final isLoading = state is ProviderServiceLoading;

                        // 🚀 Split the loading states
                        final isSavingLoading = isLoading && !_isDeleting;
                        final isDeletingLoading = isLoading && _isDeleting;

                        return Column(
                          children: [
                            SevikaButton(
                              text: isEditing
                                  ? 'Save Changes'
                                  : 'Submit for Approval',
                              icon: Icons.check_circle_outline,
                              isLoading:
                                  isSavingLoading, // 🚀 Uses specific state
                              // Disable the button if the OTHER action is loading
                              onPressed: isLoading ? null : _submitForm,
                            ),
                            if (isEditing) ...[
                              AppDimensions.gapM,
                              SevikaButton(
                                text: 'Delete Service',
                                isOutlined: true,
                                isDestructive: true,
                                icon: Icons.delete_outline,
                                isLoading:
                                    isDeletingLoading, // 🚀 Uses specific state
                                // Disable the button if the OTHER action is loading
                                onPressed: isLoading ? null : _confirmDelete,
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    AppDimensions.gapXXXL,
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

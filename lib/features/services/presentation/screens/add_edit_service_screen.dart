import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/presentation/widgets/sevika_button.dart';

import '../widgets/add/category_dropdown_field.dart';
import '../widgets/add/custom_form_field.dart';
import '../widgets/add/price_type_selector.dart';

class AddEditServiceScreen extends StatefulWidget {
  // If editing, pass the service ID. If null, we are creating a new one.
  final String? serviceId;

  const AddEditServiceScreen({super.key, this.serviceId});

  @override
  State<AddEditServiceScreen> createState() => _AddEditServiceScreenState();
}

class _AddEditServiceScreenState extends State<AddEditServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  // Form State
  String? _selectedCategory;
  String _selectedPriceType = 'Fixed Price';
  bool _isLoading = false;

  // Mocked Categories (Replace with data from your CategoriesCubit)
  final List<String> _mockCategories = [
    'Cleaning',
    'Plumbing',
    'Electrical',
    'AC Maintenance',
    'Carpentry',
  ];

  bool get isEditing => widget.serviceId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    context.unfocusKeyboard(); // 🚀 Uses your extension!

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // 👨‍🔧 Mock API Call Delay
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);

        // 🚀 Uses your custom global snackbar extension!
        context.showSnackBar(
          isEditing
              ? 'Service updated successfully!'
              : 'Service submitted for Admin approval.',
          type: SnackBarType.success,
        );

        Navigator.pop(context);
      }
    } else {
      context.showSnackBar(
        'Please fix the errors in the form.',
        type: SnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocusKeyboard(), // Dismiss keyboard on tap outside
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
                  // 1. Category Selection
                  CategoryDropdownField(
                    selectedCategory: _selectedCategory,
                    categories: _mockCategories,
                    onChanged: (val) => setState(() => _selectedCategory = val),
                  ),
                  AppDimensions.gapL,

                  // 2. Service Title
                  CustomFormField(
                    label: 'Service Title',
                    hint: 'e.g. Deep Move-Out Cleaning (3 Bedrooms)',
                    controller: _titleController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Title is required';
                      }
                      if (val.length < 5) {
                        return 'Title must be at least 5 characters long';
                      }
                      return null;
                    },
                  ),
                  AppDimensions.gapL,

                  // 3. Price Setup
                  PriceTypeSelector(
                    selectedType: _selectedPriceType,
                    onChanged: (val) =>
                        setState(() => _selectedPriceType = val),
                  ),
                  AppDimensions.gapM,

                  CustomFormField(
                    label: 'Price',
                    hint: '0.00',
                    prefixText: 'TZS ',
                    controller: _priceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Price is required';
                      if (double.tryParse(val) == null) return 'Invalid amount';
                      return null;
                    },
                  ),
                  AppDimensions.gapL,

                  // 4. Description
                  CustomFormField(
                    label: 'Description & Scope of Work',
                    hint: 'What exactly is included in this service?',
                    controller: _descriptionController,
                    maxLines: 4,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please provide a brief description';
                      }
                      return null;
                    },
                  ),
                  AppDimensions.gapXXL,

                  // 5. Submit Button (Using your custom AppButton!)
                  SevikaButton(
                    text: isEditing ? 'Save Changes' : 'Submit for Approval',
                    icon: Icons.check_circle_outline,
                    isLoading: _isLoading,
                    onPressed: _submitForm,
                  ),

                  // Optional: Delete Button if editing
                  if (isEditing) ...[
                    AppDimensions.gapM,
                    SevikaButton(
                      text: 'Delete Service',
                      isOutlined: true,
                      isDestructive: true,
                      icon: Icons.delete_outline,
                      onPressed: () {
                        // Handle deletion logic
                      },
                    ),
                  ],

                  AppDimensions.gapXXXL, // Bottom clearance
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

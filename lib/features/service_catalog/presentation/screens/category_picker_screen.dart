import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/global/presentation/widgets/sevika_state_placeholder.dart';
import '../../../categories/domain/entities/service_category_entity.dart';

class CategoryPickerScreen extends StatefulWidget {
  final List<ServiceCategoryEntity> categories;
  final String? selectedCategoryName;

  const CategoryPickerScreen({
    super.key,
    required this.categories,
    this.selectedCategoryName,
  });

  @override
  State<CategoryPickerScreen> createState() => _CategoryPickerScreenState();
}

class _CategoryPickerScreenState extends State<CategoryPickerScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // 🎯 DYNAMIC FILTERING LOGIC
    final filteredCategories = widget.categories.where((category) {
      return category.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // 🎯 UX FIX: GestureDetector added to dismiss keyboard when clicking off search
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          title: const Text('Select Category'),
          centerTitle: true,
          backgroundColor: context.colorScheme.surface,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search categories...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                      borderSide: BorderSide(
                        color: context.colorScheme.outlineVariant,
                      ),
                    ),
                    filled: true,
                    fillColor: context.colorScheme.surfaceContainerLowest,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),

              Expanded(
                child: filteredCategories.isEmpty
                    ? SevikaStatePlaceholder(
                        title: 'No Matches Found',
                        message:
                            'No categories found matching "$_searchQuery".',
                        icon: Icons.search_off_rounded,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                        ),
                        itemCount: filteredCategories.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final category = filteredCategories[index];
                          final bool isSelected =
                              category.name == widget.selectedCategoryName;

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingM,
                              vertical: AppDimensions.paddingS,
                            ),
                            title: Text(
                              category.name,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? context.colorScheme.primary
                                    : context.colorScheme.onSurface,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check_circle_rounded,
                                    color: context.colorScheme.primary,
                                  )
                                : const Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.grey,
                                  ),
                            onTap: () {
                              // 🚀 CRITICAL FIX: Return the entire entity so we have access to the ID!
                              Navigator.pop(context, category);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

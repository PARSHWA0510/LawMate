import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/math_utils.dart';

class AppSearchBar extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  const AppSearchBar({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.suffixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: MathUtilities.getResponsiveBorderRadius(12),
        border: Border.all(
          color: theme.colorScheme.outline,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
        enabled: enabled,
        readOnly: readOnly,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: enabled ? AppColors.textPrimary : AppColors.textTertiary,
        ),
        decoration: InputDecoration(
          hintText: hint ?? 'Search laws, policies, and schemes...',
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.textTertiary,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: MathUtilities.getSize(24),
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: MathUtilities.getResponsivePadding(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class AppFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const AppFilterChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipColor = backgroundColor ??
        (isSelected ? AppColors.primary : AppColors.surfaceVariant);
    final labelColor = textColor ??
        (isSelected ? AppColors.textOnPrimary : AppColors.textSecondary);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: MathUtilities.getResponsivePadding(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: MathUtilities.getResponsiveBorderRadius(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: labelColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SearchFilters extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final void Function(String?)? onCategoryChanged;
  final List<String> years;
  final String? selectedYear;
  final void Function(String?)? onYearChanged;

  const SearchFilters({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategoryChanged,
    required this.years,
    this.selectedYear,
    this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (categories.isNotEmpty) ...[
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: MathUtilities.getSize(8)),
          Wrap(
            spacing: MathUtilities.getSize(8),
            runSpacing: MathUtilities.getSize(8),
            children: [
              AppFilterChip(
                label: 'All',
                isSelected: selectedCategory == null,
                onTap: () => onCategoryChanged?.call(null),
              ),
              ...categories.map((category) => AppFilterChip(
                    label: category,
                    isSelected: selectedCategory == category,
                    onTap: () => onCategoryChanged?.call(category),
                  )),
            ],
          ),
          SizedBox(height: MathUtilities.getSize(16)),
        ],
        if (years.isNotEmpty) ...[
          Text(
            'Year',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: MathUtilities.getSize(8)),
          Wrap(
            spacing: MathUtilities.getSize(8),
            runSpacing: MathUtilities.getSize(8),
            children: [
              AppFilterChip(
                label: 'All',
                isSelected: selectedYear == null,
                onTap: () => onYearChanged?.call(null),
              ),
              ...years.map((year) => AppFilterChip(
                    label: year,
                    isSelected: selectedYear == year,
                    onTap: () => onYearChanged?.call(year),
                  )),
            ],
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/math_utils.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backgroundColor;
  final double? borderRadius;
  final Border? border;
  final VoidCallback? onTap;
  final bool isClickable;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.onTap,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget card = Container(
      margin: margin ?? MathUtilities.getResponsivePadding(all: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardTheme.color,
        borderRadius:
            MathUtilities.getResponsiveBorderRadius(borderRadius ?? 12),
        border: border,
        boxShadow: elevation != null
            ? [
                BoxShadow(
                  color: theme.shadowColor,
                  blurRadius: elevation!,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding ?? MathUtilities.getResponsivePadding(all: 12),
        child: child,
      ),
    );

    if (isClickable || onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius:
            MathUtilities.getResponsiveBorderRadius(borderRadius ?? 12),
        child: card,
      );
    }

    return card;
  }
}

class LawCard extends StatelessWidget {
  final String title;
  final String year;
  final String description;
  final String category;
  final VoidCallback? onTap;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;

  const LawCard({
    super.key,
    required this.title,
    required this.year,
    required this.description,
    required this.category,
    this.onTap,
    this.isBookmarked = false,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor = CategoryColors.getCategoryColor(category);
    final categoryIcon = CategoryColors.getCategoryIcon(category);

    return AppCard(
      onTap: onTap,
      isClickable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: MathUtilities.getResponsivePadding(all: 8),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: MathUtilities.getResponsiveBorderRadius(8),
                ),
                child: Text(
                  categoryIcon,
                  style: TextStyle(fontSize: MathUtilities.getSize(20)),
                ),
              ),
              SizedBox(width: MathUtilities.getSize(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: MathUtilities.getSize(4)),
                    Text(
                      year,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (onBookmarkTap != null)
                IconButton(
                  onPressed: onBookmarkTap,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked
                        ? AppColors.accent
                        : AppColors.textTertiary,
                  ),
                ),
            ],
          ),
          SizedBox(height: MathUtilities.getSize(12)),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: MathUtilities.getSize(8)),
          Container(
            padding: MathUtilities.getResponsivePadding(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.1),
              borderRadius: MathUtilities.getResponsiveBorderRadius(12),
            ),
            child: Text(
              category,
              style: theme.textTheme.labelSmall?.copyWith(
                color: categoryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String icon;
  final Color color;
  final VoidCallback? onTap;
  final int? count;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      onTap: onTap,
      isClickable: true,
      padding: MathUtilities.getResponsivePadding(all: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: MathUtilities.getResponsivePadding(all: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: MathUtilities.getResponsiveBorderRadius(12),
            ),
            child: Text(
              icon,
              style: TextStyle(fontSize: MathUtilities.getSize(24)),
            ),
          ),
          SizedBox(height: MathUtilities.getSize(8)),
          Flexible(
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (count != null) ...[
            SizedBox(height: MathUtilities.getSize(2)),
            Text(
              '$count laws',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: MathUtilities.getSize(10),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

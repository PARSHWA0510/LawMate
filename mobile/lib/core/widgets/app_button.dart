import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/math_utils.dart';

enum AppButtonType {
  primary,
  secondary,
  outlined,
  text,
}

enum AppButtonSize {
  small,
  medium,
  large,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: MathUtilities.getSize(_getHeight()),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 80,
          maxWidth: double.infinity,
        ),
        child: _buildButton(theme),
      ),
    );
  }

  Widget _buildButton(ThemeData theme) {
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primary,
            foregroundColor: textColor ?? AppColors.textOnPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MathUtilities.getSize(borderRadius ?? 12)),
            ),
            padding: _getPadding(),
          ),
          child: _buildContent(),
        );

      case AppButtonType.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.secondary,
            foregroundColor: textColor ?? AppColors.textOnSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MathUtilities.getSize(borderRadius ?? 12)),
            ),
            padding: _getPadding(),
          ),
          child: _buildContent(),
        );

      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppColors.primary,
            side: BorderSide(
              color: backgroundColor ?? AppColors.primary,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MathUtilities.getSize(borderRadius ?? 12)),
            ),
            padding: _getPadding(),
          ),
          child: _buildContent(),
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MathUtilities.getSize(borderRadius ?? 8)),
            ),
            padding: _getPadding(),
          ),
          child: _buildContent(),
        );
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: MathUtilities.getSize(_getIconSize()),
        height: MathUtilities.getSize(_getIconSize()),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? _getTextColor(),
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: MathUtilities.getSize(_getIconSize())),
          SizedBox(width: MathUtilities.getSize(8)),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: MathUtilities.getSize(_getFontSize()),
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: MathUtilities.getSize(_getFontSize()),
        fontWeight: FontWeight.w600,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 48;
      case AppButtonSize.large:
        return 56;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return MathUtilities.getResponsivePadding(
          horizontal: 12,
          vertical: 6,
        );
      case AppButtonSize.medium:
        return MathUtilities.getResponsivePadding(
          horizontal: 16,
          vertical: 12,
        );
      case AppButtonSize.large:
        return MathUtilities.getResponsivePadding(
          horizontal: 32,
          vertical: 16,
        );
    }
  }

  double _getFontSize() {
    switch (size) {
      case AppButtonSize.small:
        return 12;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case AppButtonType.primary:
        return AppColors.textOnPrimary;
      case AppButtonType.secondary:
        return AppColors.textOnSecondary;
      case AppButtonType.outlined:
        return AppColors.primary;
      case AppButtonType.text:
        return AppColors.primary;
    }
  }
}

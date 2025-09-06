import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2E7D32); // Dark Green
  static const Color primaryLight = Color(0xFF4CAF50); // Light Green
  static const Color primaryDark = Color(0xFF1B5E20); // Darker Green

  // Secondary Colors
  static const Color secondary = Color(0xFF1976D2); // Blue
  static const Color secondaryLight = Color(0xFF42A5F5); // Light Blue
  static const Color secondaryDark = Color(0xFF0D47A1); // Dark Blue

  // Accent Colors
  static const Color accent = Color(0xFFFF9800); // Orange
  static const Color accentLight = Color(0xFFFFB74D); // Light Orange
  static const Color accentDark = Color(0xFFE65100); // Dark Orange

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Background Colors
  static const Color backgroundPrimary = Color(0xFFFAFAFA);
  static const Color backgroundSecondary = Color(0xFFFFFFFF);
  static const Color backgroundTertiary = Color(0xFFF5F5F5);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color surfaceContainer = Color(0xFFF8F9FA);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFFBDBDBD);

  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowDark = Color(0x33000000);

  // Category Colors
  static const Color education = Color(0xFF2196F3);
  static const Color health = Color(0xFF4CAF50);
  static const Color finance = Color(0xFF9C27B0);
  static const Color employment = Color(0xFFFF9800);
  static const Color housing = Color(0xFF795548);
  static const Color environment = Color(0xFF4CAF50);
  static const Color social = Color(0xFFE91E63);
  static const Color technology = Color(0xFF607D8B);
  static const Color agriculture = Color(0xFF8BC34A);
  static const Color transport = Color(0xFF3F51B5);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextTertiary = Color(0xFF808080);
  static const Color darkBorder = Color(0xFF333333);
  static const Color darkShadow = Color(0x40000000);
}

// Category Color Helper
class CategoryColors {
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'education':
        return AppColors.education;
      case 'health':
        return AppColors.health;
      case 'finance':
        return AppColors.finance;
      case 'employment':
        return AppColors.employment;
      case 'housing':
        return AppColors.housing;
      case 'environment':
        return AppColors.environment;
      case 'social':
        return AppColors.social;
      case 'technology':
        return AppColors.technology;
      case 'agriculture':
        return AppColors.agriculture;
      case 'transport':
        return AppColors.transport;
      default:
        return AppColors.primary;
    }
  }

  static String getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'education':
        return '🎓';
      case 'health':
        return '🏥';
      case 'finance':
        return '💰';
      case 'employment':
        return '💼';
      case 'housing':
        return '🏠';
      case 'environment':
        return '🌱';
      case 'social':
        return '👥';
      case 'technology':
        return '💻';
      case 'agriculture':
        return '🌾';
      case 'transport':
        return '🚗';
      default:
        return '📋';
    }
  }
}

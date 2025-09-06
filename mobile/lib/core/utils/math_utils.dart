import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MathUtilities {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  static BuildContext? _context;

  static void setContext(BuildContext context) {
    _context = context;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getSize(double px) {
    final context = _context ?? key.currentState?.overlay?.context;
    if (context == null) {
      // Fallback for when context is not available (during app initialization)
      return px;
    }

    if (kIsWeb) {
      return px * (screenWidth(context) / 1400); // Base width for web
    } else {
      return px *
          (screenWidth(context) /
              (isPad()
                  ? 568
                  : 414)); // Base width for iPad (568) or iPhone (414)
    }
  }

  static bool isPad() {
    final context = key.currentState?.overlay?.context;
    if (context == null) return false;

    final size = MediaQuery.of(context).size;
    final diagonal = sqrt(size.width * size.width + size.height * size.height);
    return diagonal > 1100; // iPad diagonal threshold
  }

  static double getResponsiveWidth(double width) {
    final context = key.currentState?.overlay?.context;
    if (context == null) return width;

    final screenWidth = MediaQuery.of(context).size.width;
    return (width / 375) * screenWidth; // 375 is base design width
  }

  static double getResponsiveHeight(double height) {
    final context = key.currentState?.overlay?.context;
    if (context == null) return height;

    final screenHeight = MediaQuery.of(context).size.height;
    return (height / 812) * screenHeight; // 812 is base design height
  }

  static double getResponsiveFontSize(double fontSize) {
    final context = key.currentState?.overlay?.context;
    if (context == null) return fontSize;

    final screenWidth = MediaQuery.of(context).size.width;
    return (fontSize / 375) * screenWidth;
  }

  static EdgeInsets getResponsivePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      final responsiveAll = getSize(all);
      return EdgeInsets.all(responsiveAll);
    }

    return EdgeInsets.only(
      left: getSize(left ?? 0),
      top: getSize(top ?? 0),
      right: getSize(right ?? 0),
      bottom: getSize(bottom ?? 0),
    );
  }

  static BorderRadius getResponsiveBorderRadius(double radius) {
    return BorderRadius.circular(getSize(radius));
  }

  static double getResponsiveSpacing(double spacing) {
    return getSize(spacing);
  }
}

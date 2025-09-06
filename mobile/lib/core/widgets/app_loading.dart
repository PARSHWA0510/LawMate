import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/math_utils.dart';

class AppLoading extends StatelessWidget {
  final String? message;
  final double? size;
  final Color? color;

  const AppLoading({
    super.key,
    this.message,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MathUtilities.getSize(size ?? 40),
            height: MathUtilities.getSize(size ?? 40),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: MathUtilities.getSize(16)),
            Text(
              message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class AppShimmer extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: MathUtilities.getSize(widget.width),
          height: MathUtilities.getSize(widget.height),
          decoration: BoxDecoration(
            borderRadius:
                MathUtilities.getResponsiveBorderRadius(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor ?? AppColors.grey200,
                widget.highlightColor ?? AppColors.grey100,
                widget.baseColor ?? AppColors.grey200,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

class LawCardShimmer extends StatelessWidget {
  const LawCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: MathUtilities.getResponsivePadding(all: 8),
      child: Padding(
        padding: MathUtilities.getResponsivePadding(all: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const AppShimmer(
                  width: 40,
                  height: 40,
                  borderRadius: 8,
                ),
                SizedBox(width: MathUtilities.getSize(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppShimmer(
                        width: double.infinity,
                        height: 20,
                        borderRadius: 4,
                      ),
                      SizedBox(height: MathUtilities.getSize(8)),
                      const AppShimmer(
                        width: 60,
                        height: 16,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                ),
                const AppShimmer(
                  width: 24,
                  height: 24,
                  borderRadius: 12,
                ),
              ],
            ),
            SizedBox(height: MathUtilities.getSize(12)),
            const AppShimmer(
              width: double.infinity,
              height: 16,
              borderRadius: 4,
            ),
            SizedBox(height: MathUtilities.getSize(4)),
            const AppShimmer(
              width: double.infinity,
              height: 16,
              borderRadius: 4,
            ),
            SizedBox(height: MathUtilities.getSize(4)),
            const AppShimmer(
              width: 200,
              height: 16,
              borderRadius: 4,
            ),
            SizedBox(height: MathUtilities.getSize(12)),
            const AppShimmer(
              width: 80,
              height: 24,
              borderRadius: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: MathUtilities.getResponsivePadding(all: 8),
      child: Padding(
        padding: MathUtilities.getResponsivePadding(all: 20),
        child: Column(
          children: [
            const AppShimmer(
              width: 64,
              height: 64,
              borderRadius: 16,
            ),
            SizedBox(height: MathUtilities.getSize(12)),
            const AppShimmer(
              width: 100,
              height: 20,
              borderRadius: 4,
            ),
            SizedBox(height: MathUtilities.getSize(4)),
            const AppShimmer(
              width: 60,
              height: 16,
              borderRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}

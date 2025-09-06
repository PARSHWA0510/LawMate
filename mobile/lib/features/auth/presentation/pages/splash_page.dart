import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/math_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToNext();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Check authentication status and navigate accordingly
        // For now, navigate to login page
        context.go('/login');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo/Icon
                    Container(
                      width: MathUtilities.getSize(120),
                      height: MathUtilities.getSize(120),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            MathUtilities.getResponsiveBorderRadius(24),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowDark,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.gavel,
                        size: MathUtilities.getSize(60),
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: MathUtilities.getSize(32)),

                    // App Name
                    Text(
                      AppConstants.appName,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(height: MathUtilities.getSize(8)),

                    // App Tagline
                    Text(
                      AppStrings.appSubtitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MathUtilities.getSize(48)),

                    // Loading Indicator
                    SizedBox(
                      width: MathUtilities.getSize(40),
                      height: MathUtilities.getSize(40),
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/laws/presentation/pages/law_list_page.dart';
import '../../features/laws/presentation/pages/law_detail_page.dart';
import '../../features/categories/presentation/pages/category_detail_page.dart';
import '../theme/app_colors.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String lawList = '/laws';
  static const String lawDetail = '/laws';
  static const String categoryDetail = '/category';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // Splash Route
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Login Route
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),

      // Home Route
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Law List Route
      GoRoute(
        path: lawList,
        name: 'lawList',
        builder: (context, state) {
          final category = state.uri.queryParameters['category'];
          final searchQuery = state.uri.queryParameters['query'];
          return LawListPage(
            category: category,
            searchQuery: searchQuery,
          );
        },
      ),

      // Law Detail Route
      GoRoute(
        path: '/laws/:id',
        name: 'lawDetail',
        builder: (context, state) {
          final lawId = state.pathParameters['id']!;
          //Fetch law data by ID from repository
          // For now, using mock data
          final mockLaw = {
            'id': lawId,
            'title': 'Right to Education Act, 2009',
            'year': '2009',
            'description':
                'An Act to provide for free and compulsory education to all children of the age of six to fourteen years.',
            'category': 'Education',
            'isBookmarked': false,
          };
          return LawDetailPage(law: mockLaw);
        },
      ),

      // Category Detail Route
      GoRoute(
        path: '/category/:categoryName',
        name: 'categoryDetail',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          if (extra == null) {
            return const Scaffold(
              body: Center(child: Text('Category not found')),
            );
          }

          return CategoryDetailPage(
            categoryName: extra['categoryName'] ?? 'Unknown',
            categoryIcon: extra['categoryIcon'] ?? '📁',
            categoryColor: extra['categoryColor'] ?? AppColors.primary,
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Navigation helper class
class AppNavigation {
  static void goToSplash(BuildContext context) {
    context.go(AppRouter.splash);
  }

  static void goToLogin(BuildContext context) {
    context.go(AppRouter.login);
  }

  static void goToHome(BuildContext context) {
    context.go(AppRouter.home);
  }

  static void goToLawList(BuildContext context,
      {String? category, String? searchQuery}) {
    final uri = Uri(
      path: AppRouter.lawList,
      queryParameters: {
        if (category != null) 'category': category,
        if (searchQuery != null) 'query': searchQuery,
      },
    );
    context.go(uri.toString());
  }

  static void goToLawDetail(BuildContext context, String lawId) {
    context.go('${AppRouter.lawDetail}/$lawId');
  }

  static void pushLawDetail(BuildContext context, Map<String, dynamic> law) {
    context.push('/laws/${law['id']}');
  }

  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRouter.home);
    }
  }
}

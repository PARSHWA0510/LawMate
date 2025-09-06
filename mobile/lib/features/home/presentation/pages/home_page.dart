import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/math_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock data for categories
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Education',
      'icon': '🎓',
      'color': AppColors.education,
      'count': 45,
    },
    {
      'title': 'Health',
      'icon': '🏥',
      'color': AppColors.health,
      'count': 32,
    },
    {
      'title': 'Finance',
      'icon': '💰',
      'color': AppColors.finance,
      'count': 28,
    },
    {
      'title': 'Employment',
      'icon': '💼',
      'color': AppColors.employment,
      'count': 38,
    },
    {
      'title': 'Housing',
      'icon': '🏠',
      'color': AppColors.housing,
      'count': 22,
    },
    {
      'title': 'Environment',
      'icon': '🌱',
      'color': AppColors.environment,
      'count': 19,
    },
    {
      'title': 'Social',
      'icon': '👥',
      'color': AppColors.social,
      'count': 41,
    },
    {
      'title': 'Technology',
      'icon': '💻',
      'color': AppColors.technology,
      'count': 15,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      // Navigate to search results page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching for: $query'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  void _onCategoryTap(String category) {
    // Navigate to category detail page
    final categoryData =
        _categories.firstWhere((cat) => cat['title'] == category);
    context.push('/category/${category.toLowerCase()}', extra: {
      'categoryName': category,
      'categoryIcon': categoryData['icon'],
      'categoryColor': categoryData['color'],
    });
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppAppBar(
        title: AppStrings.appTitle,
        actions: [
          IconButton(
            onPressed: _onLogout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh functionality
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: MathUtilities.getResponsivePadding(all: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                width: double.infinity,
                padding: MathUtilities.getResponsivePadding(all: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryLight,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: MathUtilities.getResponsiveBorderRadius(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to LawMate',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(height: MathUtilities.getSize(8)),
                    Text(
                      'Discover and understand Indian laws, policies, and government schemes',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MathUtilities.getSize(24)),

              // Search Section
              Text(
                'Search Laws & Policies',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: MathUtilities.getSize(12)),
              AppSearchBar(
                controller: _searchController,
                onSubmitted: _onSearchSubmitted,
                hint: 'Search for laws, policies, schemes...',
              ),
              SizedBox(height: MathUtilities.getSize(24)),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Browse by Category',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all categories page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All categories coming soon!'),
                        ),
                      );
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              SizedBox(height: MathUtilities.getSize(16)),

              // Categories Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: MathUtilities.getSize(12),
                  mainAxisSpacing: MathUtilities.getSize(12),
                  childAspectRatio: 1.4,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return CategoryCard(
                    title: category['title'],
                    icon: category['icon'],
                    color: category['color'],
                    count: category['count'],
                    onTap: () => _onCategoryTap(category['title']),
                  );
                },
              ),
              SizedBox(height: MathUtilities.getSize(24)),

              // Quick Access Section
              Text(
                'Quick Access',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: MathUtilities.getSize(16)),

              // Quick Access Cards
              Row(
                children: [
                  Expanded(
                    child: _buildQuickAccessCard(
                      context,
                      'Recent Laws',
                      Icons.history,
                      AppColors.secondary,
                      () {
                        // Navigate to recent laws
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Recent laws coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: MathUtilities.getSize(12)),
                  Expanded(
                    child: _buildQuickAccessCard(
                      context,
                      'Bookmarks',
                      Icons.bookmark,
                      AppColors.accent,
                      () {
                        // Navigate to bookmarks
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bookmarks coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MathUtilities.getSize(12)),

              Row(
                children: [
                  Expanded(
                    child: _buildQuickAccessCard(
                      context,
                      'AI Assistant',
                      Icons.chat,
                      AppColors.info,
                      () {
                        // Navigate to AI assistant
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('AI Assistant coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: MathUtilities.getSize(12)),
                  Expanded(
                    child: _buildQuickAccessCard(
                      context,
                      'Compare',
                      Icons.compare,
                      AppColors.warning,
                      () {
                        // Navigate to compare
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Compare feature coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MathUtilities.getSize(24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return AppCard(
      onTap: onTap,
      isClickable: true,
      padding: MathUtilities.getResponsivePadding(all: 16),
      child: Column(
        children: [
          Container(
            padding: MathUtilities.getResponsivePadding(all: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: MathUtilities.getResponsiveBorderRadius(12),
            ),
            child: Icon(
              icon,
              size: MathUtilities.getSize(24),
              color: color,
            ),
          ),
          SizedBox(height: MathUtilities.getSize(8)),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/utils/math_utils.dart';

class LawListPage extends StatefulWidget {
  final String? category;
  final String? searchQuery;

  const LawListPage({
    super.key,
    this.category,
    this.searchQuery,
  });

  @override
  State<LawListPage> createState() => _LawListPageState();
}

class _LawListPageState extends State<LawListPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _selectedCategory;
  String? _selectedYear;
  bool _isLoading = false;
  bool _showFilters = false;

  // Mock data for laws
  final List<Map<String, dynamic>> _laws = [
    {
      'id': '1',
      'title': 'Right to Education Act, 2009',
      'year': '2009',
      'description':
          'An Act to provide for free and compulsory education to all children of the age of six to fourteen years.',
      'category': 'Education',
      'isBookmarked': false,
    },
    {
      'id': '2',
      'title': 'Consumer Protection Act, 2019',
      'year': '2019',
      'description':
          'An Act to provide for protection of the interests of consumers and for the said purpose, to establish authorities for timely and effective administration and settlement of consumers\' disputes.',
      'category': 'Finance',
      'isBookmarked': true,
    },
    {
      'id': '3',
      'title': 'Mental Healthcare Act, 2017',
      'year': '2017',
      'description':
          'An Act to provide for mental healthcare and services for persons with mental illness and to protect, promote and fulfil the rights of such persons during delivery of mental healthcare and services.',
      'category': 'Health',
      'isBookmarked': false,
    },
    {
      'id': '4',
      'title': 'Maternity Benefit (Amendment) Act, 2017',
      'year': '2017',
      'description':
          'An Act to regulate the employment of women in certain establishments for certain periods before and after child-birth and to provide for maternity benefit and certain other benefits.',
      'category': 'Employment',
      'isBookmarked': true,
    },
    {
      'id': '5',
      'title': 'Real Estate (Regulation and Development) Act, 2016',
      'year': '2016',
      'description':
          'An Act to establish the Real Estate Regulatory Authority for regulation and promotion of the real estate sector and to ensure sale of plot, apartment or building, as the case may be, or sale of real estate project.',
      'category': 'Housing',
      'isBookmarked': false,
    },
    {
      'id': '6',
      'title': 'Environment (Protection) Act, 1986',
      'year': '1986',
      'description':
          'An Act to provide for the protection and improvement of environment and for matters connected therewith.',
      'category': 'Environment',
      'isBookmarked': false,
    },
  ];

  final List<String> _categories = [
    'All',
    'Education',
    'Health',
    'Finance',
    'Employment',
    'Housing',
    'Environment',
    'Social',
    'Technology',
  ];

  final List<String> _years = [
    'All',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    'Older',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery ?? '';
    _selectedCategory = widget.category;
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreLaws();
    }
  }

  void _loadMoreLaws() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  void _onSearchSubmitted(String query) {
    // Implement search functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Searching for: $query'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _onLawTap(Map<String, dynamic> law) {
    context.push('/laws/${law['id']}');
  }

  void _onBookmarkTap(Map<String, dynamic> law) {
    setState(() {
      law['isBookmarked'] = !law['isBookmarked'];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          law['isBookmarked'] ? 'Added to bookmarks' : 'Removed from bookmarks',
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _onCategoryChanged(String? category) {
    setState(() {
      _selectedCategory = category;
    });
    // Filter laws by category
  }

  void _onYearChanged(String? year) {
    setState(() {
      _selectedYear = year;
    });
    // Filter laws by year
  }

  List<Map<String, dynamic>> get _filteredLaws {
    List<Map<String, dynamic>> filtered = List.from(_laws);

    if (_selectedCategory != null && _selectedCategory != 'All') {
      filtered = filtered
          .where((law) => law['category'] == _selectedCategory)
          .toList();
    }

    if (_selectedYear != null && _selectedYear != 'All') {
      filtered = filtered.where((law) => law['year'] == _selectedYear).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: SearchAppBar(
        controller: _searchController,
        onSubmitted: _onSearchSubmitted,
        hint: 'Search laws and policies...',
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
            ),
            tooltip: 'Filters',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters Section
          if (_showFilters)
            Container(
              padding: MathUtilities.getResponsivePadding(all: 16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  bottom: BorderSide(color: AppColors.border),
                ),
              ),
              child: SearchFilters(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategoryChanged: _onCategoryChanged,
                years: _years,
                selectedYear: _selectedYear,
                onYearChanged: _onYearChanged,
              ),
            ),

          // Results Count
          Container(
            padding: MathUtilities.getResponsivePadding(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                Text(
                  '${_filteredLaws.length} laws found',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const Spacer(),
                if (_selectedCategory != null || _selectedYear != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = null;
                        _selectedYear = null;
                      });
                    },
                    child: const Text('Clear Filters'),
                  ),
              ],
            ),
          ),

          // Laws List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Implement refresh functionality
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: MathUtilities.getResponsivePadding(all: 16),
                itemCount: _filteredLaws.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _filteredLaws.length) {
                    return const AppLoading(message: 'Loading more laws...');
                  }

                  final law = _filteredLaws[index];
                  return LawCard(
                    title: law['title'],
                    year: law['year'],
                    description: law['description'],
                    category: law['category'],
                    isBookmarked: law['isBookmarked'],
                    onTap: () => _onLawTap(law),
                    onBookmarkTap: () => _onBookmarkTap(law),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

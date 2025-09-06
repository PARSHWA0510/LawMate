import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/utils/math_utils.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryName;
  final String categoryIcon;
  final Color categoryColor;

  const CategoryDetailPage({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
  });

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _selectedYear;
  bool _isLoading = false;
  bool _showFilters = false;

  // Dummy laws data for each category
  final Map<String, List<Map<String, dynamic>>> _categoryLaws = {
    'Education': [
      {
        'id': 'edu_1',
        'title': 'Right to Education Act, 2009',
        'year': '2009',
        'description':
            'An Act to provide for free and compulsory education to all children of the age of six to fourteen years.',
        'category': 'Education',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Education',
      },
      {
        'id': 'edu_2',
        'title': 'National Education Policy, 2020',
        'year': '2020',
        'description':
            'A comprehensive framework to guide the development of education in India.',
        'category': 'Education',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Education',
      },
      {
        'id': 'edu_3',
        'title': 'Mid-Day Meal Scheme',
        'year': '1995',
        'description':
            'A school meal programme designed to better the nutritional standing of school-age children.',
        'category': 'Education',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Education',
      },
      {
        'id': 'edu_4',
        'title': 'Sarva Shiksha Abhiyan',
        'year': '2001',
        'description':
            'A flagship programme for achievement of Universalization of Elementary Education.',
        'category': 'Education',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Education',
      },
      {
        'id': 'edu_5',
        'title': 'Rashtriya Madhyamik Shiksha Abhiyan',
        'year': '2009',
        'description':
            'A centrally sponsored scheme for development of secondary education.',
        'category': 'Education',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Education',
      },
    ],
    'Health': [
      {
        'id': 'health_1',
        'title': 'Mental Healthcare Act, 2017',
        'year': '2017',
        'description':
            'An Act to provide for mental healthcare and services for persons with mental illness.',
        'category': 'Health',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Health and Family Welfare',
      },
      {
        'id': 'health_2',
        'title': 'Ayushman Bharat Yojana',
        'year': '2018',
        'description':
            'A national health protection scheme covering over 10 crore poor and vulnerable families.',
        'category': 'Health',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Health and Family Welfare',
      },
      {
        'id': 'health_3',
        'title': 'National Health Mission',
        'year': '2005',
        'description':
            'A flagship programme to address health needs of rural and urban areas.',
        'category': 'Health',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Health and Family Welfare',
      },
      {
        'id': 'health_4',
        'title': 'Janani Suraksha Yojana',
        'year': '2005',
        'description':
            'A safe motherhood intervention under the National Health Mission.',
        'category': 'Health',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Health and Family Welfare',
      },
      {
        'id': 'health_5',
        'title': 'Pradhan Mantri Jan Arogya Yojana',
        'year': '2018',
        'description':
            'A health insurance scheme for secondary and tertiary care hospitalization.',
        'category': 'Health',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Health and Family Welfare',
      },
    ],
    'Finance': [
      {
        'id': 'fin_1',
        'title': 'Consumer Protection Act, 2019',
        'year': '2019',
        'description':
            'An Act to provide for protection of the interests of consumers and for timely settlement of disputes.',
        'category': 'Finance',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Consumer Affairs',
      },
      {
        'id': 'fin_2',
        'title': 'Pradhan Mantri Jan Dhan Yojana',
        'year': '2014',
        'description':
            'A financial inclusion program to ensure access to financial services.',
        'category': 'Finance',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Finance',
      },
      {
        'id': 'fin_3',
        'title': 'Pradhan Mantri Mudra Yojana',
        'year': '2015',
        'description':
            'A scheme to provide loans up to 10 lakh to non-corporate, non-farm small/micro enterprises.',
        'category': 'Finance',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Finance',
      },
      {
        'id': 'fin_4',
        'title': 'Pradhan Mantri Jeevan Jyoti Bima Yojana',
        'year': '2015',
        'description': 'A government-backed life insurance scheme in India.',
        'category': 'Finance',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Finance',
      },
      {
        'id': 'fin_5',
        'title': 'Pradhan Mantri Suraksha Bima Yojana',
        'year': '2015',
        'description':
            'A government-backed accident insurance scheme in India.',
        'category': 'Finance',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Finance',
      },
    ],
    'Employment': [
      {
        'id': 'emp_1',
        'title': 'Maternity Benefit (Amendment) Act, 2017',
        'year': '2017',
        'description':
            'An Act to regulate the employment of women in certain establishments for certain periods before and after child-birth.',
        'category': 'Employment',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Labour and Employment',
      },
      {
        'id': 'emp_2',
        'title': 'Mahatma Gandhi National Rural Employment Guarantee Act',
        'year': '2005',
        'description':
            'An Indian social security measure that aims to guarantee the right to work.',
        'category': 'Employment',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Rural Development',
      },
      {
        'id': 'emp_3',
        'title': 'Pradhan Mantri Kaushal Vikas Yojana',
        'year': '2015',
        'description':
            'A skill development initiative scheme for recognition and standardisation of skills.',
        'category': 'Employment',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Skill Development and Entrepreneurship',
      },
      {
        'id': 'emp_4',
        'title': 'Pradhan Mantri Rojgar Protsahan Yojana',
        'year': '2016',
        'description':
            'A scheme to incentivize employers for generation of new employment.',
        'category': 'Employment',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Labour and Employment',
      },
      {
        'id': 'emp_5',
        'title': 'Pradhan Mantri Shram Yogi Maan-dhan',
        'year': '2019',
        'description': 'A pension scheme for unorganised workers.',
        'category': 'Employment',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Labour and Employment',
      },
    ],
    'Housing': [
      {
        'id': 'house_1',
        'title': 'Real Estate (Regulation and Development) Act, 2016',
        'year': '2016',
        'description':
            'An Act to establish the Real Estate Regulatory Authority for regulation and promotion of the real estate sector.',
        'category': 'Housing',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Housing and Urban Affairs',
      },
      {
        'id': 'house_2',
        'title': 'Pradhan Mantri Awas Yojana',
        'year': '2015',
        'description':
            'A scheme to provide affordable housing to the urban poor.',
        'category': 'Housing',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Housing and Urban Affairs',
      },
      {
        'id': 'house_3',
        'title': 'Pradhan Mantri Gramin Awas Yojana',
        'year': '2016',
        'description':
            'A scheme to provide pucca houses to all who are homeless or living in kutcha houses.',
        'category': 'Housing',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Rural Development',
      },
      {
        'id': 'house_4',
        'title': 'Smart Cities Mission',
        'year': '2015',
        'description':
            'An urban renewal and retrofitting program to develop smart cities.',
        'category': 'Housing',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Housing and Urban Affairs',
      },
      {
        'id': 'house_5',
        'title': 'Atal Mission for Rejuvenation and Urban Transformation',
        'year': '2015',
        'description': 'A scheme for basic infrastructure in cities and towns.',
        'category': 'Housing',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Housing and Urban Affairs',
      },
    ],
    'Environment': [
      {
        'id': 'env_1',
        'title': 'Environment (Protection) Act, 1986',
        'year': '1986',
        'description':
            'An Act to provide for the protection and improvement of environment and for matters connected therewith.',
        'category': 'Environment',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Environment, Forest and Climate Change',
      },
      {
        'id': 'env_2',
        'title': 'National Action Plan on Climate Change',
        'year': '2008',
        'description':
            'A comprehensive action plan to address climate change challenges.',
        'category': 'Environment',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Environment, Forest and Climate Change',
      },
      {
        'id': 'env_3',
        'title': 'Swachh Bharat Mission',
        'year': '2014',
        'description':
            'A campaign to clean the streets, roads and infrastructure of India.',
        'category': 'Environment',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Drinking Water and Sanitation',
      },
      {
        'id': 'env_4',
        'title': 'Pradhan Mantri Ujjwala Yojana',
        'year': '2016',
        'description':
            'A scheme to provide LPG connections to women from below poverty line households.',
        'category': 'Environment',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Petroleum and Natural Gas',
      },
      {
        'id': 'env_5',
        'title': 'National Solar Mission',
        'year': '2010',
        'description':
            'A major initiative of the Government of India and State Governments to promote ecologically sustainable growth.',
        'category': 'Environment',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of New and Renewable Energy',
      },
    ],
    'Social': [
      {
        'id': 'social_1',
        'title': 'Pradhan Mantri Jan Arogya Yojana',
        'year': '2018',
        'description':
            'A health insurance scheme for secondary and tertiary care hospitalization.',
        'category': 'Social',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Health and Family Welfare',
      },
      {
        'id': 'social_2',
        'title': 'Pradhan Mantri Garib Kalyan Yojana',
        'year': '2020',
        'description':
            'A relief package to help the poor and needy during the COVID-19 pandemic.',
        'category': 'Social',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Finance',
      },
      {
        'id': 'social_3',
        'title': 'Pradhan Mantri Kisan Samman Nidhi',
        'year': '2019',
        'description':
            'A central sector scheme to provide income support to all landholding farmers.',
        'category': 'Social',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Agriculture and Farmers Welfare',
      },
      {
        'id': 'social_4',
        'title': 'Pradhan Mantri Ujjwala Yojana',
        'year': '2016',
        'description':
            'A scheme to provide LPG connections to women from below poverty line households.',
        'category': 'Social',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Petroleum and Natural Gas',
      },
      {
        'id': 'social_5',
        'title': 'Pradhan Mantri Matru Vandana Yojana',
        'year': '2017',
        'description':
            'A maternity benefit program to provide financial assistance to pregnant and lactating mothers.',
        'category': 'Social',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Women and Child Development',
      },
    ],
    'Technology': [
      {
        'id': 'tech_1',
        'title': 'Digital India Programme',
        'year': '2015',
        'description':
            'A flagship programme to transform India into a digitally empowered society and knowledge economy.',
        'category': 'Technology',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Electronics and Information Technology',
      },
      {
        'id': 'tech_2',
        'title': 'Pradhan Mantri Gramin Digital Saksharta Abhiyan',
        'year': '2017',
        'description': 'A scheme to make rural India digitally literate.',
        'category': 'Technology',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Electronics and Information Technology',
      },
      {
        'id': 'tech_3',
        'title': 'National Digital Health Mission',
        'year': '2020',
        'description':
            'A complete digital health ecosystem to support universal health coverage.',
        'category': 'Technology',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Health and Family Welfare',
      },
      {
        'id': 'tech_4',
        'title': 'Pradhan Mantri Kaushal Vikas Yojana 3.0',
        'year': '2020',
        'description':
            'A skill development initiative with focus on digital skills and emerging technologies.',
        'category': 'Technology',
        'isBookmarked': true,
        'status': 'Active',
        'ministry': 'Ministry of Skill Development and Entrepreneurship',
      },
      {
        'id': 'tech_5',
        'title': 'National AI Strategy',
        'year': '2018',
        'description':
            'A comprehensive strategy for artificial intelligence development in India.',
        'category': 'Technology',
        'isBookmarked': false,
        'status': 'Active',
        'ministry': 'Ministry of Electronics and Information Technology',
      },
    ],
  };

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
        backgroundColor: widget.categoryColor,
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
        backgroundColor: widget.categoryColor,
      ),
    );
  }

  void _onYearChanged(String? year) {
    setState(() {
      _selectedYear = year;
    });
  }

  List<Map<String, dynamic>> get _filteredLaws {
    List<Map<String, dynamic>> laws = _categoryLaws[widget.categoryName] ?? [];

    if (_selectedYear != null && _selectedYear != 'All') {
      laws = laws.where((law) => law['year'] == _selectedYear).toList();
    }

    return laws;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: SearchAppBar(
        controller: _searchController,
        onSubmitted: _onSearchSubmitted,
        hint: 'Search in ${widget.categoryName}...',
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
          // Category Header
          Container(
            width: double.infinity,
            padding: MathUtilities.getResponsivePadding(all: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.categoryColor,
                  widget.categoryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: MathUtilities.getResponsivePadding(all: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: MathUtilities.getResponsiveBorderRadius(16),
                  ),
                  child: Text(
                    widget.categoryIcon,
                    style: TextStyle(fontSize: MathUtilities.getSize(40)),
                  ),
                ),
                SizedBox(height: MathUtilities.getSize(16)),
                Text(
                  widget.categoryName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: MathUtilities.getSize(8)),
                Text(
                  '${_filteredLaws.length} laws and policies',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.white.withOpacity(0.9),
                      ),
                ),
              ],
            ),
          ),

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by Year',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: MathUtilities.getSize(12)),
                  Wrap(
                    spacing: MathUtilities.getSize(8),
                    runSpacing: MathUtilities.getSize(8),
                    children: _years.map((year) {
                      final isSelected = _selectedYear == year;
                      return FilterChip(
                        label: Text(year),
                        selected: isSelected,
                        onSelected: (selected) {
                          _onYearChanged(selected ? year : null);
                        },
                        backgroundColor: AppColors.surfaceVariant,
                        selectedColor: widget.categoryColor.withOpacity(0.2),
                        checkmarkColor: widget.categoryColor,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? widget.categoryColor
                              : AppColors.textPrimary,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                ],
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
                if (_selectedYear != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
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

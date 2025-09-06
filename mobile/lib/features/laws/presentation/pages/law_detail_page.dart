import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/utils/math_utils.dart';

class LawDetailPage extends StatefulWidget {
  final Map<String, dynamic> law;

  const LawDetailPage({
    super.key,
    required this.law,
  });

  @override
  State<LawDetailPage> createState() => _LawDetailPageState();
}

class _LawDetailPageState extends State<LawDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;
  bool _showFullText = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _isBookmarked = widget.law['isBookmarked'] ?? false;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? 'Added to bookmarks' : 'Removed from bookmarks',
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _shareLaw() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }

  void _downloadPDF() {
    // Implement PDF download
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF download coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryColor =
        CategoryColors.getCategoryColor(widget.law['category']);
    final categoryIcon = CategoryColors.getCategoryIcon(widget.law['category']);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: DetailAppBar(
        title: widget.law['title'] as String? ?? 'Law Details',
        isBookmarked: _isBookmarked,
        onBookmarkTap: _toggleBookmark,
        actions: [
          IconButton(
            onPressed: _shareLaw,
            icon: const Icon(Icons.share),
            tooltip: 'Share',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Law Header Card
            Container(
              margin: MathUtilities.getResponsivePadding(all: 16),
              child: Card(
                elevation: 4,
                shadowColor: AppColors.shadow,
                child: Padding(
                  padding: MathUtilities.getResponsivePadding(all: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category and Year
                      Row(
                        children: [
                          Container(
                            padding: MathUtilities.getResponsivePadding(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: categoryColor.withOpacity(0.1),
                              borderRadius:
                                  MathUtilities.getResponsiveBorderRadius(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  categoryIcon,
                                  style: TextStyle(
                                      fontSize: MathUtilities.getSize(16)),
                                ),
                                SizedBox(width: MathUtilities.getSize(6)),
                                Text(
                                  widget.law['category'],
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: categoryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: MathUtilities.getResponsivePadding(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius:
                                  MathUtilities.getResponsiveBorderRadius(16),
                            ),
                            child: Text(
                              widget.law['year'],
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MathUtilities.getSize(16)),

                      // Title
                      Text(
                        widget.law['title'],
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: MathUtilities.getSize(12)),

                      // Description
                      Text(
                        widget.law['description'],
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: MathUtilities.getSize(20)),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              text: _isBookmarked ? 'Bookmarked' : 'Bookmark',
                              onPressed: _toggleBookmark,
                              type: _isBookmarked
                                  ? AppButtonType.secondary
                                  : AppButtonType.outlined,
                              icon: _isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: AppButtonSize.medium,
                            ),
                          ),
                          SizedBox(width: MathUtilities.getSize(8)),
                          Expanded(
                            child: AppButton(
                              text: 'Share',
                              onPressed: _shareLaw,
                              type: AppButtonType.outlined,
                              icon: Icons.share,
                              size: AppButtonSize.medium,
                            ),
                          ),
                          SizedBox(width: MathUtilities.getSize(8)),
                          Expanded(
                            child: AppButton(
                              text: 'PDF',
                              onPressed: _downloadPDF,
                              type: AppButtonType.outlined,
                              icon: Icons.download,
                              size: AppButtonSize.medium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tab Bar
            Container(
              margin: MathUtilities.getResponsivePadding(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: MathUtilities.getResponsiveBorderRadius(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: MathUtilities.getResponsiveBorderRadius(8),
                ),
                indicatorPadding: MathUtilities.getResponsivePadding(all: 0),
                labelPadding: MathUtilities.getResponsivePadding(
                  horizontal: 16,
                  vertical: 16,
                ),
                tabAlignment: TabAlignment.fill,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: 'Summary'),
                  Tab(text: 'Full Text'),
                  Tab(text: 'Related'),
                ],
              ),
            ),

            // Tab Content
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.6, // Fixed height for tab content
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSummaryTab(),
                  _buildFullTextTab(),
                  _buildRelatedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: MathUtilities.getResponsivePadding(all: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Summary Card
          Card(
            elevation: 2,
            child: Padding(
              padding: MathUtilities.getResponsivePadding(all: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: AppColors.accent,
                        size: MathUtilities.getSize(24),
                      ),
                      SizedBox(width: MathUtilities.getSize(8)),
                      Text(
                        'AI Summary',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: MathUtilities.getSize(16)),
                  Text(
                    'This law establishes the framework for providing free and compulsory education to all children aged 6-14 years. It mandates that every child has the right to education and places the responsibility on the government to ensure this right is fulfilled. The act also prohibits discrimination and ensures equal opportunities for all children.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MathUtilities.getSize(16)),

          // Key Points
          _buildSectionCard(
            'Key Points',
            Icons.key,
            [
              'Free and compulsory education for children aged 6-14',
              'No discrimination based on caste, creed, or gender',
              'Government responsibility to provide infrastructure',
              'Private schools must reserve 25% seats for disadvantaged children',
              'No capitation fees or screening procedures allowed',
            ],
          ),
          SizedBox(height: MathUtilities.getSize(16)),

          // Benefits
          _buildSectionCard(
            'Benefits',
            Icons.thumb_up,
            [
              'Ensures universal access to elementary education',
              'Reduces dropout rates and improves literacy',
              'Promotes social equality and inclusion',
              'Strengthens the education system infrastructure',
              'Empowers children with fundamental rights',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFullTextTab() {
    return SingleChildScrollView(
      padding: MathUtilities.getResponsivePadding(all: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle for full text
          Row(
            children: [
              Text(
                'Full Text',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showFullText = !_showFullText;
                  });
                },
                child: Text(_showFullText ? 'Show Less' : 'Show More'),
              ),
            ],
          ),
          SizedBox(height: MathUtilities.getSize(16)),

          // Law Text
          Card(
            elevation: 2,
            child: Padding(
              padding: MathUtilities.getResponsivePadding(all: 20),
              child: Text(
                _showFullText ? _getFullLawText() : _getShortLawText(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedTab() {
    // Mock related laws
    final relatedLaws = [
      {
        'title': 'National Education Policy, 2020',
        'year': '2020',
        'category': 'Education',
      },
      {
        'title': 'Mid-Day Meal Scheme',
        'year': '1995',
        'category': 'Education',
      },
      {
        'title': 'Sarva Shiksha Abhiyan',
        'year': '2001',
        'category': 'Education',
      },
    ];

    return ListView.builder(
      padding: MathUtilities.getResponsivePadding(all: 16),
      itemCount: relatedLaws.length,
      itemBuilder: (context, index) {
        final law = relatedLaws[index];
        return Card(
          margin: EdgeInsets.only(bottom: MathUtilities.getSize(12)),
          child: ListTile(
            leading: Container(
              padding: MathUtilities.getResponsivePadding(all: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: MathUtilities.getResponsiveBorderRadius(8),
              ),
              child: Icon(
                Icons.gavel,
                color: AppColors.primary,
                size: MathUtilities.getSize(20),
              ),
            ),
            title: Text(
              law['title'] as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            subtitle: Text(
              '${law['year']} • ${law['category']}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to related law
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${law['title']}')),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<String> items) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: MathUtilities.getResponsivePadding(all: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon,
                    color: AppColors.primary, size: MathUtilities.getSize(24)),
                SizedBox(width: MathUtilities.getSize(8)),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            SizedBox(height: MathUtilities.getSize(16)),
            ...items.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: MathUtilities.getSize(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MathUtilities.getSize(6),
                        height: MathUtilities.getSize(6),
                        margin: EdgeInsets.only(
                          top: MathUtilities.getSize(8),
                          right: MathUtilities.getSize(12),
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                  ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String _getShortLawText() {
    return 'An Act to provide for free and compulsory education to all children of the age of six to fourteen years. This Act may be called the Right of Children to Free and Compulsory Education Act, 2009. It extends to the whole of India except the State of Jammu and Kashmir. It shall come into force on such date as the Central Government may, by notification in the Official Gazette, appoint...';
  }

  String _getFullLawText() {
    return '''An Act to provide for free and compulsory education to all children of the age of six to fourteen years.

BE it enacted by Parliament in the Sixtieth Year of the Republic of India as follows:—

CHAPTER I
PRELIMINARY

1. Short title, extent and commencement.—(1) This Act may be called the Right of Children to Free and Compulsory Education Act, 2009.

(2) It extends to the whole of India except the State of Jammu and Kashmir.

(3) It shall come into force on such date as the Central Government may, by notification in the Official Gazette, appoint.

2. Definitions.—In this Act, unless the context otherwise requires,—

(a) "appropriate Government" means—

(i) in relation to a school established, owned or controlled by the Central Government, or the administrator of the Union territory, having no legislature, the Central Government;

(ii) in relation to a school, other than the school referred to in sub-clause (i), established within the territory of—

(A) a State, the State Government;

(B) a Union territory having legislature, the Government of that Union territory;

(b) "capitation fee" means any kind of donation or contribution or payment, by whatever name, other than the fee notified by the school;

(c) "child" means a male or female child of the age of six to fourteen years;

(d) "child belonging to disadvantaged group" means a child belonging to the Scheduled Caste, the Scheduled Tribe, the socially and educationally backward class or such other group having disadvantage owing to social, cultural, economical, geographical, linguistic, gender or such other factor, as may be specified by the appropriate Government, by notification;

(e) "child belonging to weaker section" means a child belonging to such parent or guardian whose annual income is lower than the minimum limit specified by the appropriate Government, by notification;

(f) "elementary education" means the education from first class to eighth class;

(g) "guardian", in relation to a child, means a person having the care and custody of that child and includes—

(i) a natural guardian;

(ii) an adoptive parent;

(iii) a guardian appointed or declared by a court; and

(iv) a person who is willing to take care of the child and is so authorised by the child or his parents;

(h) "local authority" means a Municipal Corporation or Municipal Council or Zila Parishad or Nagar Panchayat or Panchayat, by whatever name called, and includes such other authority or body having administrative control over the school or empowered by or under any law for the time being in force to function as a local authority in any city, town or village;

(i) "National Commission for Protection of Child Rights" means the National Commission for Protection of Child Rights constituted under section 3 of the Commissions for Protection of Child Rights Act, 2005;

(j) "notification" means a notification published in the Official Gazette;

(k) "parent" means either the natural or step or adoptive father or mother of a child;

(l) "prescribed" means prescribed by rules made under this Act;

(m) "school" means any recognised school imparting elementary education and includes—

(i) a school established, owned or controlled by the appropriate Government or a local authority;

(ii) an aided school receiving aid or grants to meet whole or part of its expenses from the appropriate Government or the local authority;

(iii) a school belonging to specified category; and

(iv) an unaided school not receiving any kind of aid or grants to meet its expenses from the appropriate Government or the local authority;

(n) "screening procedure" means the method of selection for admission of a child, in preference over another, other than a random method;

(o) "specified category", in relation to a school, means a school known as Kendriya Vidyalaya, Navodaya Vidyalaya, Sainik School, or any other school having a distinct character which may be specified, by notification, by the appropriate Government;

(p) "State Commission for Protection of Child Rights" means the State Commission for Protection of Child Rights constituted under section 3 of the Commissions for Protection of Child Rights Act, 2005 or a State Commission for Protection of Child Rights constituted under any corresponding law for the time being in force in a State;

(q) "State Government", in relation to a Union territory, means the Administrator of that Union territory appointed by the President under article 239 of the Constitution.

CHAPTER II
RIGHT TO FREE AND COMPULSORY EDUCATION

3. Right of child to free and compulsory education.—(1) Every child of the age of six to fourteen years shall have a right to free and compulsory education in a neighbourhood school till completion of elementary education.

(2) For the purpose of sub-section (1), no child shall be liable to pay any kind of fee or charges or expenses which may prevent him or her from pursuing and completing the elementary education.

(3) A child suffering from disability, as defined in clause (i) of section 2 of the Persons with Disabilities (Equal Opportunities, Protection of Rights and Full Participation) Act, 1995, shall have the same rights to free and compulsory education to which a child without disability has under this Act.

(4) Where a child above six years of age has not been admitted in any school or though admitted, could not complete his or her elementary education, then, he or she shall be admitted in a class appropriate to his or her age:

Provided that where a child is directly admitted in a class appropriate to his or her age, then, he or she shall, in order to be at par with others, have a right to receive special training, in such manner, and within such time-limits, as may be prescribed:

Provided further that a child so admitted to elementary education shall be entitled to free education till completion of elementary education even after fourteen years.

(5) For the purpose of this section, the expression "compulsory education" means obligation of the appropriate Government to—

(a) provide free elementary education to every child of the age of six to fourteen years; and

(b) ensure compulsory admission, attendance and completion of elementary education by every child of the age of six to fourteen years.

(6) For the purpose of sub-section (1), a child shall be admitted in a school at the commencement of the academic year or within such extended period as may be prescribed:

Provided that no child shall be denied admission in a school for lack of age proof if he or she has completed six years of age.

(7) A child who completes elementary education shall be awarded a certificate, in such form and in such manner, as may be prescribed.

(8) No child shall be held back in any class or expelled from school till the completion of elementary education.

(9) The appropriate Government and the local authority shall ensure that the child belonging to weaker section and the child belonging to disadvantaged group are not discriminated against and prevented from pursuing and completing elementary education on any grounds.''';
  }
}

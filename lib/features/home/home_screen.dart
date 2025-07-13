import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _contentController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  void _startAnimations() async {
    _backgroundController.forward();
    
    await Future.delayed(const Duration(milliseconds: 300));
    _contentController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UniversalBackground(animation: _backgroundController),
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: AnimatedBuilder(
        animation: _contentController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  SliverPadding(
                    padding: EdgeInsets.all(context.sizing.l),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildWelcomeSection(),
                        SizedBox(height: context.sizing.xxl),
                        _buildQuickActionsSection(),
                        SizedBox(height: context.sizing.xxl),
                        _buildRecentActivitySection(),
                        SizedBox(height: context.sizing.xxl),
                        _buildStatsSection(),
                        SizedBox(height: context.sizing.xxl),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: context.sizing.size(100),
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.sizing.xs),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(context.sizing.radiusS),
              ),
              child: Icon(
                Icons.school,
                color: AppColors.onPrimary,
                size: context.sizing.iconS,
              ),
            ),
            SizedBox(width: context.sizing.s),
            Text(
              'Okoa Sem',
              style: context.typography.titleM.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        titlePadding: EdgeInsets.only(
          left: context.sizing.l,
          bottom: context.sizing.m,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
          },
          icon: Icon(
            Icons.notifications_outlined,
            color: AppColors.primary,
          ),
        ),
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
          },
          icon: Container(
            padding: EdgeInsets.all(context.sizing.xs),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(context.sizing.radiusS),
            ),
            child: Icon(
              Icons.person_outline,
              color: AppColors.secondary,
              size: context.sizing.iconS,
            ),
          ),
        ),
        SizedBox(width: context.sizing.s),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: EdgeInsets.all(context.sizing.l),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(context.sizing.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: context.sizing.size(15),
            spreadRadius: context.sizing.size(2),
            offset: Offset(0, context.sizing.size(5)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back! 👋',
            style: context.typography.headlineM.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: context.sizing.s),
          Text(
            'Ready to ace your exams? Let\'s explore past papers and study materials.',
            style: context.typography.bodyL.copyWith(
              color: AppColors.onPrimary.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
          SizedBox(height: context.sizing.l),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: context.sizing.l,
                vertical: context.sizing.m,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.sizing.radiusL),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search,
                  size: context.sizing.iconS,
                ),
                SizedBox(width: context.sizing.s),
                Text(
                  'Start Searching',
                  style: context.typography.labelL.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: context.typography.headlineS.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: context.sizing.l),
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final spacing = context.sizing.m;
            final cardWidth = (availableWidth - spacing) / 2;
            
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildActionCard(
                    icon: Icons.library_books,
                    title: 'Past Papers',
                    subtitle: 'Browse by school',
                    color: AppColors.primary,
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildActionCard(
                    icon: Icons.psychology,
                    title: 'Topic Search',
                    subtitle: 'AI-powered search',
                    color: AppColors.secondary,
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildActionCard(
                    icon: Icons.camera_alt,
                    title: 'Notes to Questions',
                    subtitle: 'Upload & generate',
                    color: AppColors.tertiary,
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildActionCard(
                    icon: Icons.share,
                    title: 'Share & Collaborate',
                    subtitle: 'Study together',
                    color: AppColors.info,
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: context.sizing.size(120),
          maxHeight: context.sizing.size(140),
        ),
        padding: EdgeInsets.all(context.sizing.m),
        decoration: BoxDecoration(
          color: context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(context.sizing.radiusL),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: context.sizing.size(10),
              offset: Offset(0, context.sizing.size(4)),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(context.sizing.s),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(context.sizing.radiusM),
              ),
              child: Icon(
                icon,
                color: color,
                size: context.sizing.iconM,
              ),
            ),
            SizedBox(height: context.sizing.s),
            Flexible( 
              child: Text(
                title,
                style: context.typography.titleS.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: context.sizing.xs / 2), 
            Flexible( 
              child: Text(
                subtitle,
                style: context.typography.bodyS.copyWith(
                  color: context.colors.surfaceAlpha(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: context.typography.headlineS.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w900,
              ),
            ),
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
              },
              child: Text(
                'View All',
                style: context.typography.labelM.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.sizing.l),
        _buildActivityItem(
          icon: Icons.quiz,
          title: 'Generated 5 questions from Chemistry notes',
          time: '2 hours ago',
          color: AppColors.success,
        ),
        SizedBox(height: context.sizing.m),
        _buildActivityItem(
          icon: Icons.search,
          title: 'Searched for "Organic Chemistry" past papers',
          time: '1 day ago',
          color: AppColors.info,
        ),
        SizedBox(height: context.sizing.m),
        _buildActivityItem(
          icon: Icons.share,
          title: 'Shared question set with Study Group',
          time: '3 days ago',
          color: AppColors.warning,
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(context.sizing.m),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(context.sizing.radiusM),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.sizing.s),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(context.sizing.radiusS),
            ),
            child: Icon(
              icon,
              color: color,
              size: context.sizing.iconS,
            ),
          ),
          SizedBox(width: context.sizing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.typography.bodyM.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: context.sizing.xs),
                Text(
                  time,
                  style: context.typography.bodyS.copyWith(
                    color: context.colors.surfaceAlpha(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: context.typography.headlineS.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: context.sizing.l),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Questions Generated',
                value: '124',
                color: AppColors.primary,
                icon: Icons.quiz,
              ),
            ),
            SizedBox(width: context.sizing.m),
            Expanded(
              child: _buildStatCard(
                title: 'Study Sessions',
                value: '18',
                color: AppColors.secondary,
                icon: Icons.timer,
              ),
            ),
          ],
        ),
        SizedBox(height: context.sizing.m),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Papers Downloaded',
                value: '45',
                color: AppColors.tertiary,
                icon: Icons.download,
              ),
            ),
            SizedBox(width: context.sizing.m),
            Expanded(
              child: _buildStatCard(
                title: 'Topics Mastered',
                value: '8',
                color: AppColors.success,
                icon: Icons.star,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(context.sizing.l),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(context.sizing.radiusL),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(context.sizing.s),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(context.sizing.radiusS),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: context.sizing.iconS,
                ),
              ),
            ],
          ),
          SizedBox(height: context.sizing.m),
          Text(
            value,
            style: context.typography.headlineM.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: context.sizing.xs),
          Text(
            title,
            style: context.typography.bodyS.copyWith(
              color: context.colors.surfaceAlpha(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
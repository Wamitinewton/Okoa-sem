import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/core/failures/auth_failure.dart';
import 'package:okoa_sem/di/injection_container.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_event.dart';
import 'package:okoa_sem/features/auth/presentation/bloc/auth_state.dart';
import 'package:okoa_sem/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _backgroundController;
  
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

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  void _startAnimations() async {
    _backgroundController.forward();
    
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        body: Stack(
          children: [
            UniversalBackground(animation: _backgroundController),
            _buildMainContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: AnimatedBuilder(
        animation: Listenable.merge([_fadeController, _slideController]),
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.all(context.sizing.l),
                child: Column(
                  children: [
                    _buildTopSection(),
                    const Spacer(),
                    _buildWelcomeSection(),
                    SizedBox(height: context.sizing.xxl),
                    _buildAuthSection(),
                    SizedBox(height: context.sizing.xl),
                    _buildFooterSection(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopSection() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.sizing.s),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(context.sizing.radiusM),
          ),
          child: Icon(
            Icons.school,
            color: AppColors.onPrimary,
            size: context.sizing.iconM,
          ),
        ),
        SizedBox(width: context.sizing.s),
        Text(
          'Okoa Sem',
          style: context.typography.titleL.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        Container(
          width: context.sizing.size(120),
          height: context.sizing.size(120),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(context.sizing.radiusXL),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: context.sizing.size(20),
                spreadRadius: context.sizing.size(5),
              ),
            ],
          ),
          child: Icon(
            Icons.celebration,
            size: context.sizing.size(60),
            color: AppColors.onPrimary,
          ),
        ),
        
        SizedBox(height: context.sizing.xl),
        
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: AppColors.primaryGradient,
          ).createShader(bounds),
          child: Text(
            'Welcome Back!',
            style: context.typography.headlineL.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        SizedBox(height: context.sizing.s),
        
        Text(
          'Sign in to continue your academic journey',
          style: context.typography.bodyL.copyWith(
            color: context.colors.surfaceAlpha(0.8),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAuthSection() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome back, ${user.displayName}!'),
                backgroundColor: AppColors.success,
              ),
            );
          },
          error: (failure, user) {
            HapticFeedback.mediumImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: AppColors.error,
              ),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.isLoading;
        
        return Column(
          children: [
            GoogleSignInButton(
              onPressed: isLoading ? null : () {
                HapticFeedback.lightImpact();
                context.read<AuthBloc>().add(const AuthEvent.signInWithGoogle());
              },
              isLoading: isLoading,
            ),
            
            SizedBox(height: context.sizing.l),
            
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.sizing.l,
                vertical: context.sizing.m,
              ),
              decoration: BoxDecoration(
                color: context.colors.surfaceVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(context.sizing.radiusL),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.info,
                    size: context.sizing.iconS,
                  ),
                  SizedBox(width: context.sizing.s),
                  Expanded(
                    child: Text(
                      'Sign in with your Google account to access all features',
                      style: context.typography.bodyS.copyWith(
                        color: context.colors.surfaceAlpha(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFooterSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFeatureChip(Icons.school, 'Past Papers'),
            SizedBox(width: context.sizing.s),
            _buildFeatureChip(Icons.quiz, 'Smart Search'),
            SizedBox(width: context.sizing.s),
            _buildFeatureChip(Icons.group, 'Study Groups'),
          ],
        ),
        
        SizedBox(height: context.sizing.l),
        
        Text(
          'By signing in, you agree to our Terms of Service and Privacy Policy',
          style: context.typography.bodyS.copyWith(
            color: context.colors.surfaceAlpha(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sizing.s,
        vertical: context.sizing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.sizing.radiusL),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: context.sizing.iconS,
            color: AppColors.primary,
          ),
          SizedBox(width: context.sizing.xs),
          Text(
            label,
            style: context.typography.labelS.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
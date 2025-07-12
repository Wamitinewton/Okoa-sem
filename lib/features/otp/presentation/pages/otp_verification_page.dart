import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/core/enums/otp_enums.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/features/otp/presentation/widgets/otp_input_filed.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_event.dart';
import 'package:okoa_sem/features/otp/presentation/bloc/otp_state.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;
  final OtpType type;
  final String? title;
  final String? subtitle;

  const OtpVerificationPage({
    super.key,
    required this.email,
    this.type = OtpType.emailVerification,
    this.title,
    this.subtitle,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage>
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
    _sendInitialOtp();
  }

  void _initializeAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  void _startAnimations() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _backgroundController.forward();
      _contentController.forward();
    });
  }

  void _sendInitialOtp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OtpBloc>().add(
        OtpSendRequested(
          email: widget.email,
          type: widget.type,
        ),
      );
    });
  }

  void _handleOtpChanged(String code) {
    context.read<OtpBloc>().add(OtpCodeChanged(code));
  }

  void _handleOtpCompleted() {
    final state = context.read<OtpBloc>().state;
    if (state.canVerify) {
      HapticFeedback.lightImpact();
      context.read<OtpBloc>().add(
        OtpVerifyRequested(
          email: widget.email,
          code: state.code,
          type: widget.type,
        ),
      );
    }
  }

  void _handleResendOtp() {
    HapticFeedback.mediumImpact();
    context.read<OtpBloc>().add(
      OtpResendRequested(
        email: widget.email,
        type: widget.type,
      ),
    );
  }

  void _handleVerifyPressed() {
    final state = context.read<OtpBloc>().state;
    if (state.canVerify) {
      _handleOtpCompleted();
    }
  }

  void _navigateToLogin() {
    AppRoute.login.go(context);
  }

  String get _displayTitle {
    return widget.title ?? widget.type.displayName;
  }

  String get _displaySubtitle {
    return widget.subtitle ?? 
           'We\'ve sent a 6-digit verification code to ${_maskEmail(widget.email)}';
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    
    final username = parts[0];
    final domain = parts[1];
    
    if (username.length <= 2) return email;
    
    final maskedUsername = username.substring(0, 2) + 
                          '*' * (username.length - 2);
    
    return '$maskedUsername@$domain';
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
          
          SafeArea(
            child: BlocListener<OtpBloc, OtpState>(
              listener: _handleBlocStateChanges,
              child: AnimatedBuilder(
                animation: _contentController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildContent(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBlocStateChanges(BuildContext context, OtpState state) {
    if (state.status == OtpStatus.verified) {
      HapticFeedback.heavyImpact();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email verified successfully! 🎉',
            style: context.typography.bodyM.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sizing.radiusM),
          ),
          margin: EdgeInsets.all(context.sizing.m),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          _navigateToLogin();
        }
      });
    } else if (state.status == OtpStatus.failed && state.errorMessage != null) {
      HapticFeedback.mediumImpact();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.errorMessage!,
            style: context.typography.bodyM.copyWith(
              color: AppColors.onPrimarySurface,
            ),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sizing.radiusM),
          ),
          margin: EdgeInsets.all(context.sizing.m),
        ),
      );
    }
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.sizing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: context.sizing.l),
          
          _buildHeader(),
          
          SizedBox(height: context.sizing.xxl),
          
          _buildOtpSection(),
          
          SizedBox(height: context.sizing.xl),
          
          _buildTimerSection(),
          
          SizedBox(height: context.sizing.l),
          
          _buildResendSection(),
          
          SizedBox(height: context.sizing.xl),
          
          _buildActionButtons(),
          
          SizedBox(height: context.sizing.l),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(context.sizing.l),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.accentGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(context.sizing.radiusXL),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: context.sizing.size(15),
                spreadRadius: context.sizing.size(2),
                offset: Offset(0, context.sizing.size(5)),
              ),
            ],
          ),
          child: Icon(
            Icons.mark_email_read_outlined,
            size: context.sizing.size(48),
            color: AppColors.onPrimary,
          ),
        ),
        
        SizedBox(height: context.sizing.xl),
        
        Text(
          _displayTitle,
          style: context.typography.headlineL.copyWith(
            fontWeight: FontWeight.w900,
            color: context.colors.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: context.sizing.s),
        
        Text(
          _displaySubtitle,
          style: context.typography.bodyL.copyWith(
            color: context.colors.surfaceAlpha(0.7),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpSection() {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(context.sizing.l),
          decoration: BoxDecoration(
            color: context.colors.surfaceVariant.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(context.sizing.radiusL),
            border: Border.all(
              color: context.colors.border,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Enter Verification Code',
                style: context.typography.titleM.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: context.sizing.l),
              
              OtpInputField(
                value: state.code,
                onChanged: _handleOtpChanged,
                onCompleted: _handleOtpCompleted,
                hasError: state.status.isError,
                enabled: !state.status.isLoading && state.attemptsLeft > 0,
              ),
              
              if (state.attemptsLeft < 3 && state.attemptsLeft > 0) ...[
                SizedBox(height: context.sizing.s),
                Text(
                  '${state.attemptsLeft} attempt${state.attemptsLeft == 1 ? '' : 's'} remaining',
                  style: context.typography.bodyS.copyWith(
                    color: context.colors.warning,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimerSection() {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        if (!state.isTimerActive) return const SizedBox.shrink();
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.sizing.l,
            vertical: context.sizing.s,
          ),
          decoration: BoxDecoration(
            color: context.colors.primaryAlpha(0.1),
            borderRadius: BorderRadius.circular(context.sizing.radiusL),
            border: Border.all(
              color: context.colors.primaryAlpha(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer_outlined,
                size: context.sizing.iconS,
                color: context.colors.primary,
              ),
              SizedBox(width: context.sizing.xs),
              Text(
                'Code expires in ${state.formattedTimeRemaining}',
                style: context.typography.bodyS.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResendSection() {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              "Didn't receive the code?",
              style: context.typography.bodyM.copyWith(
                color: context.colors.surfaceAlpha(0.7),
              ),
            ),
            
            SizedBox(height: context.sizing.s),
            
            TextButton(
              onPressed: state.canRequestResend ? _handleResendOtp : null,
              style: TextButton.styleFrom(
                foregroundColor: context.colors.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: context.sizing.l,
                  vertical: context.sizing.s,
                ),
              ),
              child: state.status == OtpStatus.resending
                  ? SizedBox(
                      width: context.sizing.iconS,
                      height: context.sizing.iconS,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.colors.primary,
                        ),
                      ),
                    )
                  : Text(
                      state.canRequestResend ? 'Resend Code' : 'Please wait...',
                      style: context.typography.labelL.copyWith(
                        color: state.canRequestResend
                            ? context.colors.primary
                            : context.colors.disabled,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.canVerify ? _handleVerifyPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  padding: EdgeInsets.symmetric(
                    vertical: context.sizing.m,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.sizing.radiusL),
                  ),
                  elevation: state.canVerify ? 4 : 0,
                  shadowColor: context.colors.primaryAlpha(0.3),
                ),
                child: state.status == OtpStatus.verifying
                    ? SizedBox(
                        height: context.sizing.iconS,
                        width: context.sizing.iconS,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.colors.onPrimary,
                          ),
                        ),
                      )
                    : Text(
                        'Verify Code',
                        style: context.typography.labelL.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.onPrimary,
                        ),
                      ),
              ),
            ),
            
            SizedBox(height: context.sizing.m),
            
            TextButton(
              onPressed: _navigateToLogin,
              style: TextButton.styleFrom(
                foregroundColor: context.colors.surfaceAlpha(0.7),
                padding: EdgeInsets.symmetric(
                  horizontal: context.sizing.l,
                  vertical: context.sizing.s,
                ),
              ),
              child: Text(
                'Back to Login',
                style: context.typography.labelL.copyWith(
                  color: context.colors.surfaceAlpha(0.7),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
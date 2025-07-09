import 'package:flutter/material.dart';
import 'package:okoa_sem/core/config/app_config.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.sizing.s),
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(context.sizing.radiusM),
              ),
              child: Icon(
                Icons.school,
                color: context.colors.onPrimary,
                size: context.sizing.iconM,
              ),
            ),
            SizedBox(width: context.sizing.s),
            Text(
              'Okoa Sem',
              style: context.typography.titleL.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        
        SizedBox(height: context.sizing.xl),
        
        Text(
          title,
          style: context.typography.headlineL.copyWith(
            fontWeight: FontWeight.w900,
            color: context.colors.onSurface,
          ),
        ),
        
        SizedBox(height: context.sizing.xs),
        
        Text(
          subtitle,
          style: context.typography.bodyL.copyWith(
            color: context.colors.surfaceAlpha(0.7),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.sizing.buttonL,
      child: isSecondary
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: context.colors.primary,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.sizing.radiusM),
                ),
              ),
              child: _buildButtonChild(context),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.sizing.radiusM),
                ),
                elevation: 2,
                shadowColor: context.colors.primaryAlpha(0.3),
              ),
              child: _buildButtonChild(context),
            ),
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: context.sizing.iconS,
        width: context.sizing.iconS,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isSecondary ? context.colors.primary : context.colors.onPrimary,
          ),
        ),
      );
    }

    return Text(
      text,
      style: context.typography.labelL.copyWith(
        fontWeight: FontWeight.bold,
        color: isSecondary ? context.colors.primary : context.colors.onPrimary,
      ),
    );
  }
}

class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider({
    super.key,
    this.text = 'or',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: context.colors.divider,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.sizing.m),
          child: Text(
            text,
            style: context.typography.bodyS.copyWith(
              color: context.colors.surfaceAlpha(0.6),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: context.colors.divider,
          ),
        ),
      ],
    );
  }
}

class AuthFooter extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onActionPressed;

  const AuthFooter({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: context.typography.bodyM.copyWith(
            color: context.colors.surfaceAlpha(0.7),
          ),
        ),
        SizedBox(width: context.sizing.xs),
        GestureDetector(
          onTap: onActionPressed,
          child: Text(
            actionText,
            style: context.typography.bodyM.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class AuthFormContainer extends StatelessWidget {
  final Widget child;

  const AuthFormContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
      child: child,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okoa_sem/core/config/app_config.dart';

enum SnackBarType { success, error, info, warning }

class CustomSnackBars {
  static void show({
    required BuildContext context,
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onActionPressed,
    bool hapticFeedback = true,
  }) {
    if (hapticFeedback) {
      _triggerHapticFeedback(type);
    }

    final snackBar = SnackBar(
      content: _SnackBarContent(
        message: message,
        type: type,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(AppSizing.spacingM(context)),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: _getActionColor(type),
              onPressed: onActionPressed ?? () {},
            )
          : null,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 5),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void _triggerHapticFeedback(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        HapticFeedback.lightImpact();
        break;
      case SnackBarType.error:
        HapticFeedback.heavyImpact();
        break;
      case SnackBarType.info:
        HapticFeedback.selectionClick();
        break;
      case SnackBarType.warning:
        HapticFeedback.mediumImpact();
        break;
    }
  }

  static Color _getActionColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.error:
        return AppColors.error;
      case SnackBarType.info:
        return AppColors.info;
      case SnackBarType.warning:
        return AppColors.warning;
    }
  }
}

class _SnackBarContent extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const _SnackBarContent({
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizing.spacingL(context),
        vertical: AppSizing.spacingM(context),
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(AppSizing.radiusL(context)),
        border: Border.all(
          color: _getBorderColor(),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: AppSizing.size(context, 8),
            offset: Offset(0, AppSizing.size(context, 2)),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSizing.spacingS(context)),
            decoration: BoxDecoration(
              color: _getIconBackgroundColor(),
              borderRadius: BorderRadius.circular(AppSizing.radiusS(context)),
            ),
            child: Icon(
              _getIcon(),
              color: _getIconColor(),
              size: AppSizing.iconS(context),
            ),
          ),
          
          SizedBox(width: AppSizing.spacingM(context)),
          
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyMediumStyle(context).copyWith(
                color: _getTextColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success.withValues(alpha: 0.1);
      case SnackBarType.error:
        return AppColors.error.withValues(alpha: 0.1);
      case SnackBarType.info:
        return AppColors.info.withValues(alpha: 0.1);
      case SnackBarType.warning:
        return AppColors.warning.withValues(alpha: 0.1);
    }
  }

  Color _getBorderColor() {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success.withValues(alpha: 0.3);
      case SnackBarType.error:
        return AppColors.error.withValues(alpha: 0.3);
      case SnackBarType.info:
        return AppColors.info.withValues(alpha: 0.3);
      case SnackBarType.warning:
        return AppColors.warning.withValues(alpha: 0.3);
    }
  }

  Color _getIconBackgroundColor() {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success.withValues(alpha: 0.2);
      case SnackBarType.error:
        return AppColors.error.withValues(alpha: 0.2);
      case SnackBarType.info:
        return AppColors.info.withValues(alpha: 0.2);
      case SnackBarType.warning:
        return AppColors.warning.withValues(alpha: 0.2);
    }
  }

  Color _getIconColor() {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.error:
        return AppColors.error;
      case SnackBarType.info:
        return AppColors.info;
      case SnackBarType.warning:
        return AppColors.warning;
    }
  }

  Color _getTextColor() {
    return AppColors.onSurface;
  }

  IconData _getIcon() {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
    }
  }
}
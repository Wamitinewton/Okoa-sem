enum OtpType {
  emailVerification,
  passwordReset,
  twoFactorAuth,
}

enum OtpStatus {
  initial,
  sending,
  sent,
  verifying,
  verified,
  expired,
  failed,
  resending,
}

extension OtpTypeExtension on OtpType {
  String get displayName {
    switch (this) {
      case OtpType.emailVerification:
        return 'Email Verification';
      case OtpType.passwordReset:
        return 'Password Reset';
      case OtpType.twoFactorAuth:
        return 'Two Factor Authentication';
    }
  }

  String get description {
    switch (this) {
      case OtpType.emailVerification:
        return 'Please verify your email address to continue';
      case OtpType.passwordReset:
        return 'Enter the code to reset your password';
      case OtpType.twoFactorAuth:
        return 'Enter the verification code for security';
    }
  }
}

extension OtpStatusExtension on OtpStatus {
  bool get isLoading => this == OtpStatus.sending || 
                       this == OtpStatus.verifying || 
                       this == OtpStatus.resending;
  
  bool get canResend => this == OtpStatus.sent || 
                       this == OtpStatus.failed || 
                       this == OtpStatus.expired;
  
  bool get isError => this == OtpStatus.failed || 
                     this == OtpStatus.expired;
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';
import 'package:okoa_sem/core/router/route.dart';
import 'package:okoa_sem/core/utils/validation_utils.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/international_phone_field.dart';
import '../widgets/auth_widgets.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  late AnimationController _backgroundController;
  bool _isPhoneLogin = false;
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _backgroundController.forward();
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_isPhoneLogin) {
        // Login with phone OTP
        context.read<AuthBloc>().add(
          SignInWithPhoneRequested(phoneNumber: _phoneNumber),
        );
      } else {
        // Login with username/password
        context.read<AuthBloc>().add(
          SignInWithPasswordRequested(
            username: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
      }
    }
  }

  void _toggleLoginMethod() {
    setState(() {
      _isPhoneLogin = !_isPhoneLogin;
    });

    // Clear form fields when switching
    _usernameController.clear();
    _passwordController.clear();
    _phoneController.clear();
    _phoneNumber = '';
  }

  void _navigateToSignup() {
    AppRoute.signup.go(context);
  }

  void _navigateToOtpVerification(String phoneNumber) {
    AppRoute.otpVerification.go(
      context,
      queryParameters: {
        'phone': phoneNumber,
        'type': 'phoneVerification',
        'title': 'Sign In Verification',
        'subtitle':
            'We\'ve sent a 6-digit verification code to $phoneNumber. Please enter it below to sign in.',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UniversalBackground(animation: _backgroundController),

          SafeArea(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage ?? 'An error occurred',
                        style: context.typography.bodyM.copyWith(
                          color: AppColors.onPrimarySurface,
                        ),
                      ),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.sizing.radiusM,
                        ),
                      ),
                      margin: EdgeInsets.all(context.sizing.m),
                    ),
                  );
                } else if (state.status == AuthStatus.authenticated) {
                  AppRoute.home.go(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Login successful! 🎉',
                        style: context.typography.bodyM.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.sizing.radiusM,
                        ),
                      ),
                      margin: EdgeInsets.all(context.sizing.m),
                    ),
                  );
                } else if (state.status == AuthStatus.otpSent) {
                  _navigateToOtpVerification(_phoneNumber);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Verification code sent! 📱',
                        style: context.typography.bodyM.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.sizing.radiusM,
                        ),
                      ),
                      margin: EdgeInsets.all(context.sizing.m),
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.sizing.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.sizing.l),

                    // Header
                    const AuthHeader(
                      title: 'Welcome Back!',
                      subtitle:
                          'Sign in to continue your academic journey with Okoa Sem',
                    ),

                    SizedBox(height: context.sizing.xl),

                    _buildLoginMethodToggle(),

                    SizedBox(height: context.sizing.l),

                    AuthFormContainer(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (_isPhoneLogin) ...[
                              InternationalPhoneField(
                                label: 'Phone Number',
                                hintText: '712 345 678',
                                controller: _phoneController,
                                isRequired: true,
                                validator: ValidationUtils
                                    .validateInternationalPhoneNumber,
                                onChanged: (phoneNumber) {
                                  setState(() {
                                    _phoneNumber = phoneNumber;
                                  });
                                },
                              ),
                            ] else ...[
                              CustomInputField(
                                label: 'Username',
                                hintText: 'Enter your username',
                                controller: _usernameController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                isRequired: true,
                                validator: ValidationUtils.validateUsername,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: context.colors.surfaceAlpha(0.7),
                                  size: context.sizing.iconM,
                                ),
                              ),

                              SizedBox(height: context.sizing.l),

                              CustomInputField(
                                label: 'Password',
                                hintText: 'Enter your password',
                                controller: _passwordController,
                                isPassword: true,
                                textInputAction: TextInputAction.done,
                                isRequired: true,
                                validator: ValidationUtils.validatePassword,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: context.colors.surfaceAlpha(0.7),
                                  size: context.sizing.iconM,
                                ),
                              ),

                              SizedBox(height: context.sizing.s),
                            ],

                            SizedBox(height: context.sizing.xl),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return AuthButton(
                                  text: _isPhoneLogin ? 'Send Code' : 'Sign In',
                                  onPressed: _handleLogin,
                                  isLoading: state.status == AuthStatus.loading,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: context.sizing.xl),

                    const AuthDivider(),

                    SizedBox(height: context.sizing.xl),

                    Center(
                      child: AuthFooter(
                        questionText: "Don't have an account?",
                        actionText: 'Sign Up',
                        onActionPressed: _navigateToSignup,
                      ),
                    ),

                    SizedBox(height: context.sizing.l),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginMethodToggle() {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(context.sizing.radiusL),
        border: Border.all(color: context.colors.border, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_isPhoneLogin) _toggleLoginMethod();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: context.sizing.s),
                decoration: BoxDecoration(
                  color: !_isPhoneLogin
                      ? context.colors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(context.sizing.radiusL),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: context.sizing.iconS,
                      color: !_isPhoneLogin
                          ? context.colors.onPrimary
                          : context.colors.surfaceAlpha(0.7),
                    ),
                    SizedBox(width: context.sizing.xs),
                    Text(
                      'Username',
                      style: context.typography.labelM.copyWith(
                        color: !_isPhoneLogin
                            ? context.colors.onPrimary
                            : context.colors.surfaceAlpha(0.7),
                        fontWeight: !_isPhoneLogin
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!_isPhoneLogin) _toggleLoginMethod();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: context.sizing.s),
                decoration: BoxDecoration(
                  color: _isPhoneLogin
                      ? context.colors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(context.sizing.radiusL),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: context.sizing.iconS,
                      color: _isPhoneLogin
                          ? context.colors.onPrimary
                          : context.colors.surfaceAlpha(0.7),
                    ),
                    SizedBox(width: context.sizing.xs),
                    Text(
                      'Phone',
                      style: context.typography.labelM.copyWith(
                        color: _isPhoneLogin
                            ? context.colors.onPrimary
                            : context.colors.surfaceAlpha(0.7),
                        fontWeight: _isPhoneLogin
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/core/utils/validation_utils.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';
import 'package:okoa_sem/core/router/route.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/kenyan_phone_field.dart';
import '../widgets/auth_widgets.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _backgroundController;
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
    _phoneController.dispose();
    _passwordController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignupWithPhoneRequested(
          phoneNumber: _phoneNumber,
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  void _navigateToLogin() {
    AppRoute.login.go(context);
  }

  void _navigateToOtpVerification(String phoneNumber) {
    AppRoute.otpVerification.go(
      context,
      queryParameters: {
        'phone': phoneNumber,
        'type': 'phoneVerification',
        'title': 'Verify Your Phone',
        'subtitle': 'We\'ve sent a 6-digit verification code to $phoneNumber. Please enter it below to complete your registration.',
      }
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
                      title: 'Create Account',
                      subtitle:
                          'Join Okoa Sem and start your academic success journey today',
                    ),

                    SizedBox(height: context.sizing.xxl),

                    AuthFormContainer(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomInputField(
                              label: 'Username',
                              hintText: 'Choose a unique username',
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

                            KenyanPhoneField(
                              label: 'Phone Number',
                              hintText: '712 345 678',
                              controller: _phoneController,
                              isRequired: true,
                              validator: ValidationUtils.validateKenyanPhoneNumber,
                              onChanged: (phoneNumber) {
                                setState(() {
                                  _phoneNumber = phoneNumber;
                                });
                              },
                            ),

                            SizedBox(height: context.sizing.l),

                            CustomInputField(
                              label: 'Password',
                              hintText: 'Create a strong password',
                              controller: _passwordController,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              isRequired: true,
                              validator: ValidationUtils.validateStrongPassword,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: context.colors.surfaceAlpha(0.7),
                                size: context.sizing.iconM,
                              ),
                            ),

                            SizedBox(height: context.sizing.s),

                            Container(
                              padding: EdgeInsets.all(context.sizing.s),
                              decoration: BoxDecoration(
                                color: context.colors.primaryAlpha(0.1),
                                borderRadius: BorderRadius.circular(
                                  context.sizing.radiusS,
                                ),
                                border: Border.all(
                                  color: context.colors.primaryAlpha(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Password Requirements:',
                                    style: context.typography.labelS.copyWith(
                                      color: context.colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: context.sizing.xs),
                                  _buildPasswordRequirement(
                                    'At least 8 characters',
                                  ),
                                  _buildPasswordRequirement(
                                    'One uppercase letter',
                                  ),
                                  _buildPasswordRequirement(
                                    'One lowercase letter',
                                  ),
                                  _buildPasswordRequirement('One number'),
                                ],
                              ),
                            ),

                            SizedBox(height: context.sizing.xl),

                            // Terms and Conditions
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'By creating an account, you agree to our ',
                                style: context.typography.bodyS.copyWith(
                                  color: context.colors.surfaceAlpha(0.7),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: context.typography.bodyS.copyWith(
                                      color: context.colors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: context.typography.bodyS.copyWith(
                                      color: context.colors.surfaceAlpha(0.7),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: context.typography.bodyS.copyWith(
                                      color: context.colors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: context.sizing.l),

                            // Signup Button
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return AuthButton(
                                  text: 'Create Account',
                                  onPressed: _handleSignup,
                                  isLoading: state.status == AuthStatus.loading,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: context.sizing.xl),

                    // Divider
                    const AuthDivider(),

                    SizedBox(height: context.sizing.xl),

                    // Footer
                    Center(
                      child: AuthFooter(
                        questionText: 'Already have an account?',
                        actionText: 'Sign In',
                        onActionPressed: _navigateToLogin,
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

  Widget _buildPasswordRequirement(String text) {
    return Padding(
      padding: EdgeInsets.only(top: context.sizing.xs),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: context.sizing.iconS,
            color: context.colors.primaryAlpha(0.7),
          ),
          SizedBox(width: context.sizing.xs),
          Text(
            text,
            style: context.typography.bodyS.copyWith(
              color: context.colors.surfaceAlpha(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
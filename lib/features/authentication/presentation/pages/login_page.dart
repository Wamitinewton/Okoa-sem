import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okoa_sem/core/config/app_config.dart';
import 'package:okoa_sem/shared/widgets/universal_background.dart';
import 'package:okoa_sem/core/router/route.dart';
import '../widgets/custom_input_field.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _backgroundController;

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
    _emailController.dispose();
    _passwordController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  String? _validateEmailOrUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or username is required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        LoginRequested(
          emailOrUsername: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  void _navigateToSignup() {
    AppRoute.signup.go(context);
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
                        borderRadius: BorderRadius.circular(context.sizing.radiusM),
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
                        borderRadius: BorderRadius.circular(context.sizing.radiusM),
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
                      subtitle: 'Sign in to continue your academic journey with Okoa Sem',
                    ),
                    
                    SizedBox(height: context.sizing.xxl),
                    
                    // Form Container
                    AuthFormContainer(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email/Username Field
                            CustomInputField(
                              label: 'Email or Username',
                              hintText: 'Enter your email or username',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              isRequired: true,
                              validator: _validateEmailOrUsername,
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: context.colors.surfaceAlpha(0.7),
                                size: context.sizing.iconM,
                              ),
                            ),
                            
                            SizedBox(height: context.sizing.l),
                            
                            // Password Field
                            CustomInputField(
                              label: 'Password',
                              hintText: 'Enter your password',
                              controller: _passwordController,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              isRequired: true,
                              validator: _validatePassword,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: context.colors.surfaceAlpha(0.7),
                                size: context.sizing.iconM,
                              ),
                            ),
                            
                            SizedBox(height: context.sizing.s),
                            
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: context.typography.bodyS.copyWith(
                                    color: context.colors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            
                            SizedBox(height: context.sizing.xl),
                            
                            // Login Button
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return AuthButton(
                                  text: 'Sign In',
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
                    
                    // Divider
                    const AuthDivider(),
                    
                    SizedBox(height: context.sizing.xl),
                    
                    // Footer
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
}
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_frame.dart';
import '../data/auth_repository.dart';
import '../view_model/auth_view_model.dart';
import '../widgets/auth_widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    required this.repository,
    required this.onSignUp,
    required this.onLoginSuccess,
    super.key,
  });

  final AuthRepository repository;
  final VoidCallback onSignUp;
  final VoidCallback onLoginSuccess;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel _vm;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _vm = LoginViewModel(widget.repository)..addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _vm
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (await _vm.submit() && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome back to Munchly! 🎉',
            style: AppText.inter(fontSize: 14),
          ),
          backgroundColor: AppColors.orange,
          behavior: SnackBarBehavior.floating,
          shape: const StadiumBorder(),
        ),
      );
      widget.onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: AuthFrame(
        isLogin: true,
        title: 'Munchly',
        subtitle: 'Crave it. Get it.',
        form: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthField(
                label: 'EMAIL ADDRESS',
                controller: _vm.email,
                hint: 'kaushal@munchly.app',
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),

              AuthField(
                label: 'PASSWORD',
                controller: _vm.password,
                hint: '••••••••',
                obscureText: _vm.obscurePassword,
                suffix: IconButton(
                  onPressed: _vm.togglePasswordVisibility,
                  splashRadius: 20,
                  icon: Icon(
                    _vm.obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.muted,
                  ),
                ),
                validator: (v) => v == null || v.length < 6
                    ? 'Enter at least 6 characters'
                    : null,
              ),

              if (_vm.errorMessage != null) ErrorText(_vm.errorMessage!),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.orange,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot password?',
                    style: AppText.inter(
                      fontSize: 13,
                      color: AppColors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              PrimaryButton(
                label: 'Log in',
                loading: _vm.isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
        bottom: Column(
          children: [
            const DividerText(text: 'or continue with'),
            const SocialButtons(),
            const SizedBox(height: 20),
            accountPrompt(
              "Don't have an account?  ",
              'Sign up',
              widget.onSignUp,
            ),
          ],
        ),
      ),
    );
  }
}

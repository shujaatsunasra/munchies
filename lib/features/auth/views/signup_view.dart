import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_frame.dart';
import '../data/auth_repository.dart';
import '../view_model/auth_view_model.dart';
import '../widgets/auth_widgets.dart';

class SignupView extends StatefulWidget {
  const SignupView({
    required this.repository,
    required this.onLogin,
    required this.onRegistered,
    super.key,
  });

  final AuthRepository repository;
  final VoidCallback onLogin;
  final VoidCallback onRegistered;

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final SignupViewModel _vm;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _vm = SignupViewModel(widget.repository)..addListener(_refresh);
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
    if (!_vm.acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms & Privacy Policy.',
            style: AppText.inter(fontSize: 13),
          ),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          shape: const StadiumBorder(),
        ),
      );
      return;
    }
    if (await _vm.submit() && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Account created! Welcome to Munchly 🎉',
            style: AppText.inter(fontSize: 14),
          ),
          backgroundColor: AppColors.orange,
          behavior: SnackBarBehavior.floating,
          shape: const StadiumBorder(),
        ),
      );
      widget.onRegistered();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: AuthFrame(
        title: 'Join Munchly',
        subtitle: "Let's get your first order on its way",
        form: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthField(
                label: 'YOUR NAME',
                controller: _vm.name,
                hint: 'Kaushal',
                validator: (v) =>
                    v == null || v.trim().length < 2 ? 'Enter your name' : null,
              ),

              AuthField(
                label: 'EMAIL ADDRESS',
                controller: _vm.email,
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),

              AuthField(
                label: 'MOBILE NUMBER',
                controller: _vm.mobile,
                hint: '9876543210',
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.trim().length < 10
                    ? 'Enter a valid mobile number'
                    : null,
              ),

              
              _GenderSelector(
                selectedGender: _vm.gender,
                onGenderChanged: _vm.setGender,
              ),

              AuthField(
                label: 'CREATE PASSWORD',
                controller: _vm.password,
                hint: 'At least 8 characters',
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
                validator: (v) =>
                    v == null || v.length < 8 ? 'At least 8 characters' : null,
              ),

              if (_vm.errorMessage != null) ErrorText(_vm.errorMessage!),

              
              GestureDetector(
                onTap: () => _vm.toggleTerms(!_vm.acceptedTerms),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _vm.acceptedTerms,
                        onChanged: (v) => _vm.toggleTerms(v ?? false),
                        activeColor: AppColors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: const BorderSide(
                          color: AppColors.fieldBorder,
                          width: 1.5,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppText.inter(
                            fontSize: 11,
                            color: AppColors.muted,
                            height: 1.3,
                          ),
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: AppText.inter(
                                fontSize: 11,
                                color: AppColors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const TextSpan(text: ' & '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppText.inter(
                                fontSize: 11,
                                color: AppColors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              PrimaryButton(
                label: 'Create account',
                loading: _vm.isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
        bottom: Column(
          children: [
            const DividerText(text: 'or sign up with'),
            const SocialButtons(),
            const SizedBox(height: 14),
            accountPrompt(
              'Already have an account?  ',
              'Log in',
              widget.onLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({
    required this.selectedGender,
    required this.onGenderChanged,
  });

  final String selectedGender;
  final ValueChanged<String> onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GENDER',
            style: AppText.inter(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _GenderOption(
                  label: 'Male',
                  value: 'male',
                  groupValue: selectedGender,
                  onChanged: onGenderChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GenderOption(
                  label: 'Female',
                  value: 'female',
                  groupValue: selectedGender,
                  onChanged: onGenderChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GenderOption(
                  label: 'Other',
                  value: 'other',
                  groupValue: selectedGender,
                  onChanged: onGenderChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.orange.withValues(alpha: 0.08)
              : AppColors.fieldBg,
          border: Border.all(
            color: isSelected ? AppColors.orange : AppColors.fieldBorder,
            width: isSelected ? 1.5 : 1.2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: AppText.inter(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.orange : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

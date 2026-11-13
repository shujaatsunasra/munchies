import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class AuthFrame extends StatelessWidget {
  const AuthFrame({
    required this.title,
    required this.subtitle,
    required this.form,
    required this.bottom,
    this.isLogin = false,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget form;
  final Widget bottom;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        
        const Positioned(
          top: -80,
          left: -60,
          child: _Circle(320, Color(0x28FF6B35)),
        ),
        
        const Positioned(
          bottom: -70,
          right: -50,
          child: _Circle(350, Color(0x22FF6B35)),
        ),
        
        Positioned(
          top: MediaQuery.of(context).size.height * 0.35,
          right: -40,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFB89D).withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
          ),
        ),

        
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: isLogin ? 24 : 16),

                      
                      Image.asset(
                        'assets/mark-96.png',
                        width: isLogin ? 140 : 110,
                        height: isLogin ? 140 : 110,
                      ),
                      SizedBox(height: isLogin ? 12 : 8),

                      
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppText.inter(
                          color: AppColors.ink,
                          fontSize: isLogin ? 28 : 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),

                      
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: AppText.inter(
                          color: AppColors.muted,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: isLogin ? 20 : 16),

                      
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          isLogin ? 18 : 16,
                          16,
                          isLogin ? 18 : 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0E000000),
                              blurRadius: 24,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: form,
                      ),

                      SizedBox(height: isLogin ? 18 : 14),
                      bottom,
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle(this.size, this.color);
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

class AuthField extends StatelessWidget {
  const AuthField({
    required this.label,
    required this.controller,
    required this.hint,
    this.validator,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.readOnly = false,
    super.key,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffix;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppText.inter(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            readOnly: readOnly,
            keyboardType: keyboardType,
            style: AppText.inter(
              fontSize: 14.5,
              color: AppColors.ink,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppText.inter(
                fontSize: 14.5,
                color: AppColors.muted.withValues(alpha: 0.55),
              ),
              suffixIcon: suffix,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 12,
              ),
              isDense: true,
              filled: true,
              fillColor: AppColors.fieldBg,
              border: _border(),
              enabledBorder: _border(),
              focusedBorder: _border(AppColors.orange),
              errorBorder: _border(AppColors.errorRed),
              focusedErrorBorder: _border(AppColors.errorRed),
              errorStyle: AppText.inter(
                fontSize: 10.5,
                color: AppColors.errorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border([Color color = AppColors.fieldBorder]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 1.2),
      );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.loading = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ink,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.ink.withValues(alpha: 0.55),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: const StadiumBorder(),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: loading
              ? const SizedBox(
                  key: ValueKey('spinner'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                    strokeCap: StrokeCap.round,
                  ),
                )
              : Text(
                  label,
                  key: ValueKey('label'),
                  style: AppText.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _socialBtn('assets/icon-chrome.png', 'Google')),
        const SizedBox(width: 10),
        Expanded(child: _socialBtn('assets/icon-apple.png', 'Apple')),
      ],
    );
  }

  Widget _socialBtn(String asset, String label) => OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColors.fieldBorder, width: 1.2),
      padding: const EdgeInsets.symmetric(vertical: 11),
      backgroundColor: Colors.white,
      shape: const StadiumBorder(),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(asset, width: 17, height: 17),
        const SizedBox(width: 7),
        Text(
          label,
          style: AppText.inter(
            fontSize: 13,
            color: AppColors.ink,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class DividerText extends StatelessWidget {
  const DividerText({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.fieldBorder.withValues(alpha: 0.7),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: AppText.inter(fontSize: 12, color: AppColors.muted),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.fieldBorder.withValues(alpha: 0.7),
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}

class ErrorText extends StatelessWidget {
  const ErrorText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppText.inter(color: AppColors.errorRed, fontSize: 13),
      ),
    ),
  );
}

String? emailValidator(String? value) =>
    value == null ||
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())
    ? 'Enter a valid email address'
    : null;

Widget accountPrompt(String prefix, String action, VoidCallback onTap) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      prefix,
      style: AppText.inter(color: AppColors.muted, fontSize: 13),
    ),
    GestureDetector(
      onTap: onTap,
      child: Text(
        action,
        style: AppText.inter(
          color: AppColors.orange,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ],
);

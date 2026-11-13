import 'package:flutter/material.dart';

import '../data/auth_repository.dart';

abstract class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this.repository);

  final AuthRepository repository;
  bool isLoading = false;
  String? errorMessage;

  void clearError() {
    if (errorMessage == null) return;
    errorMessage = null;
    notifyListeners();
  }

  void _startRequest() {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
  }

  void _finishRequest(String? error) {
    isLoading = false;
    errorMessage = error;
    notifyListeners();
  }
}

class LoginViewModel extends AuthViewModel {
  LoginViewModel(super.repository);

  final email = TextEditingController();
  final password = TextEditingController();
  bool obscurePassword = true;

  Future<bool> submit() async {
    _startRequest();
    final error = await repository.login(
      identifier: email.text.trim(),
      password: password.text,
    );
    _finishRequest(error);
    return error == null;
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}

class SignupViewModel extends AuthViewModel {
  SignupViewModel(super.repository);

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  
  final mobile = TextEditingController();

  
  String gender = 'male';

  bool obscurePassword = true;
  bool acceptedTerms = false;

  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  void toggleTerms(bool value) {
    acceptedTerms = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<bool> submit() async {
    _startRequest();
    final error = await repository.register(
      name: name.text.trim(),
      email: email.text.trim(),
      password: password.text,
      mobile: mobile.text.trim().isEmpty ? '0000000000' : mobile.text.trim(),
      gender: gender,
    );
    _finishRequest(error);
    return error == null;
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    mobile.dispose();
    super.dispose();
  }
}

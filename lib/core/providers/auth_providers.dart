import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/data/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

final authStateProvider = StateProvider<AuthState>((ref) => AuthState.initial());

class AuthState {
  final bool isAuthenticated;
  final String? userId;
  final bool isLoading;
  final String? error;

  AuthState({
    required this.isAuthenticated,
    this.userId,
    this.isLoading = false,
    this.error,
  });

  factory AuthState.initial() => AuthState(isAuthenticated: false);

  AuthState copyWith({
    bool? isAuthenticated,
    String? userId,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.initial());

  Future<bool> login(String identifier, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final error = await _repository.login(
      identifier: identifier,
      password: password,
    );

    if (error == null) {
      state = state.copyWith(
        isAuthenticated: true,
        userId: identifier,
        isLoading: false,
      );
      return true;
    } else {
      state = state.copyWith(isLoading: false, error: error);
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String gender,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final error = await _repository.register(
      name: name,
      email: email,
      password: password,
      mobile: mobile,
      gender: gender,
    );

    if (error == null) {
      state = state.copyWith(
        isAuthenticated: true,
        userId: email,
        isLoading: false,
      );
      return true;
    } else {
      state = state.copyWith(isLoading: false, error: error);
      return false;
    }
  }

  void logout() {
    state = AuthState.initial();
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

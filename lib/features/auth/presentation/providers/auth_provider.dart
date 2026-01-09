import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

// Auth state
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState());

  Future<void> checkAuthStatus() async {
    state = state.copyWith(status: AuthStatus.loading);
    
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      final result = await _authRepository.getCurrentUser();
      result.fold(
        (error) => state = state.copyWith(status: AuthStatus.unauthenticated),
        (user) => state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ),
      );
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    return result.fold(
      (error) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: error,
        );
        return false;
      },
      (authResponse) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: authResponse.user,
        );
        return true;
      },
    );
  }

  Future<bool> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    String? name,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _authRepository.register(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      name: name,
    );

    return result.fold(
      (error) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: error,
        );
        return false;
      },
      (authResponse) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: authResponse.user,
        );
        return true;
      },
    );
  }

  Future<bool> signInWithApple() async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final result = await _authRepository.signInWithApple(
        identityToken: credential.identityToken ?? '',
        authorizationCode: credential.authorizationCode,
        email: credential.email,
        fullName: [credential.givenName, credential.familyName]
            .where((e) => e != null)
            .join(' '),
      );

      return result.fold(
        (error) {
          state = state.copyWith(
            status: AuthStatus.error,
            errorMessage: error,
          );
          return false;
        },
        (authResponse) {
          state = state.copyWith(
            status: AuthStatus.authenticated,
            user: authResponse.user,
          );
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Apple sign-in was cancelled',
      );
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(status: AuthStatus.loading);
    await _authRepository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

// Current user provider
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authProvider).user;
});


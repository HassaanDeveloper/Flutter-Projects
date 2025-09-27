import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/core/services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signUp(event.email, event.password);
        emit(AuthAuthenticated(_authService.currentUser!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.login(event.email, event.password);
        emit(AuthAuthenticated(_authService.currentUser!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthForgotPassword>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.forgotPassword(event.email);
        emit(AuthPasswordResetSent());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthSignOut>((event, emit) async {
      await _authService.signOut();
      emit(AuthInitial());
    });

    on<AuthCheckStatus>((event, emit) {
      final user = _authService.currentUser;
      if (user != null && user.emailVerified) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthInitial());
      }
    });
  }
}
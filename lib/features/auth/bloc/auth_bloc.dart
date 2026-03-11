import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_event.dart';
import 'package:taghyeer_assessment/features/auth/bloc/auth_state.dart';
import 'package:taghyeer_assessment/features/auth/repo/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _repo;

  AuthBloc(this._repo) : super(AuthInitial()) {
    on<AuthCheckCacheRequested>(_onCheckCache);
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onCheckCache(
    AuthCheckCacheRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final user = await _repo.getCachedUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _repo.login(event.username, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repo.logout();
    emit(AuthLoggedOut());
  }
}

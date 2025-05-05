import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/core/cookies/cookie_manager.dart';
import 'package:esalesapp/models/user/user_model.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthenticationState> emit) async {
    debugPrint("[AUTH] AppStarted triggered");

    emit(AuthenticationInitial());
    await Future.delayed(const Duration(milliseconds: 3000)); // tampilkan splash sebentar

    emit(AuthenticationPreCheckHasToken());

    bool hasToken = false;

    if (AppData.kIsWeb) {
      final token = CookieManager.getCookie('token');
      if (token != null && token.isNotEmpty) {
        AppData.userToken = token;
        hasToken = true;
      }
    } else {
      hasToken = await userRepository.hasToken();
    }

    emit(AuthenticationPostCheckHasToken());

    if (hasToken) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    debugPrint("[AUTH] LoggedIn triggered");
    emit(AuthenticationLoading());

    if (!AppData.kIsWeb && event.remember) {
      await userRepository.persistToken(user: event.user);
    }

    AppData.user = event.user;
    AppData.userToken = event.user.token ?? '';

    emit(AuthenticationAuthenticated());
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    debugPrint("[AUTH] LoggedOut triggered");
    emit(AuthenticationLoading());

    if (AppData.kIsWeb) {
      CookieManager.clearAll();
    } else {
      await userRepository.deleteToken(id: 0);
    }

    AppData.user = User(id: 0, username: '', nama: '', token: '');
    AppData.userToken = '';

    emit(AuthenticationUnauthenticated());
  }
}

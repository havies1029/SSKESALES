import 'dart:async';

import 'package:esalesapp/common/app_data.dart';
import 'package:equatable/equatable.dart';
import 'package:esalesapp/core/cookies/cookie_manager.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';
import 'package:esalesapp/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUnauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    debugPrint("_onAppStarted");

    emit(AuthenticationPreCheckHasToken());
    bool hasToken = false;
    // bool hasToken = AppData.kIsWeb ? false : await userRepository.hasToken();
    emit(AuthenticationPostCheckHasToken());


    // Cookie
    if (AppData.kIsWeb) {
      // Kalau Web, cek dari cookie
      String? token = CookieManager.getCookie('token');
      if (token != null && token.isNotEmpty) {
        AppData.userToken = token;
        hasToken = true;
      }
    } else {
      // Kalau Mobile, cek dari local database
      hasToken = await userRepository.hasToken();
    }

    //debugPrint("hasToken ?");
    if (hasToken) {
      emit(AuthenticationAuthenticated());
      //debugPrint("hasToken ? yes -> ${AppData.userToken}");
    } else {
      //debugPrint("hasToken ? no");
      emit(AuthenticationUnauthenticated());
      //debugPrint("hasToken ? no -> proceed");
    }
  }

  Future<void> _onLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    // if (!AppData.kIsWeb) {
    //   if (event.remember) {
    //     await userRepository.persistToken(user: event.user);
    //   }
    // }

    if (AppData.kIsWeb) {
      // Kalau Web, AppData sudah diisi di LoginBloc
      // Tidak perlu apa-apa di sini
    } else {
      // Kalau Mobile, simpan ke database lokal
      if (event.remember) {
        await userRepository.persistToken(user: event.user);
      }
    }

    AppData.user = event.user;

    emit(AuthenticationAuthenticated());
  }

  Future<void> _onLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    // if (!AppData.kIsWeb) {
    //   await userRepository.deleteToken(id: 0);
    //   //userRepository.dropTableUser();
    // }

    if (AppData.kIsWeb) {
      //  Kalau Web, hapus semua cookie user
      CookieManager.clearAll();
    } else {
      // Kalau Mobile, hapus dari local database
      await userRepository.deleteToken(id: 0);
      //userRepository.dropTableUser();
    }

    emit(AuthenticationUnauthenticated());
  }
}

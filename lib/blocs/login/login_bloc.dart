import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    debugPrint("_onLoginButtonPressed #10");

    emit(LoginInitial());
    try {
      final user = await userRepository.authenticate(
        username: event.username,
        password: event.password,
      );
      //debugPrint("_onLoginButtonPressed #20");
      emit(LoginPreAuthenticate());
      //debugPrint("_onLoginButtonPressed #30");
      authenticationBloc.add(LoggedIn(user: user));
      //debugPrint("_onLoginButtonPressed #40");
      emit(LoginPostAuthenticate());
      //debugPrint("_onLoginButtonPressed #50");
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}

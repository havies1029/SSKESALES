import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';
import 'package:esalesapp/core/cookies/cookie_manager.dart';
import 'package:equatable/equatable.dart';

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
    
    emit(LoginInitial());
    emit(LoginLoading());
    
    try {
      final user = await userRepository.authenticate(
        username: event.username,
        password: event.password,
      );

      // Simpan ke Cookie
      CookieManager.setCookie('id', user.id.toString(), remember: event.remember);
      CookieManager.setCookie('username', user.username ?? '', remember: event.remember);
      CookieManager.setCookie('nama', user.nama ?? '', remember: event.remember);
      CookieManager.setCookie('personId', user.personId ?? '', remember: event.remember);
      CookieManager.setCookie('hp', user.hp ?? '', remember: event.remember);
      CookieManager.setCookie('email', user.email ?? '', remember: event.remember);
      CookieManager.setCookie('alamat1', user.alamat1 ?? '', remember: event.remember);
      CookieManager.setCookie('alamat2', user.alamat2 ?? '', remember: event.remember);
      CookieManager.setCookie('propinsiId', user.propinsiId ?? '', remember: event.remember);
      CookieManager.setCookie('propinsiDesc', user.propinsiDesc ?? '', remember: event.remember);
      CookieManager.setCookie('jnskel', user.jnskel ?? '', remember: event.remember);
      CookieManager.setCookie('userCabang', user.userCabang ?? '', remember: event.remember);
      // CookieManager.setCookie('hasDownline', user.hasDownline ?? '', remember: event.remember);
      CookieManager.setCookie('token', user.token ?? '', remember: event.remember);
      // CookieManager.setCookie('foto', user.foto ?? '', remember: event.remember);

      emit(LoginPreAuthenticate());      
      authenticationBloc.add(LoggedIn(user: user, remember: event.remember));      
      emit(LoginPostAuthenticate());            
    } catch (error) {      
      emit(LoginFailure(error: error.toString()));
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';
import 'package:esalesapp/core/cookies/cookie_manager.dart';

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

      // Simpan ke Cookie (gunakan try-catch per item jika perlu robustness ekstra)
      final Map<String, dynamic> userMap = {
        'id': user.id.toString(),
        'username': user.username ?? '',
        'nama': user.nama ?? '',
        'personId': user.personId ?? '',
        'hp': user.hp ?? '',
        'email': user.email ?? '',
        'alamat1': user.alamat1 ?? '',
        'alamat2': user.alamat2 ?? '',
        'propinsiId': user.propinsiId ?? '',
        'propinsiDesc': user.propinsiDesc ?? '',
        'jnskel': user.jnskel ?? '',
        'userCabang': user.userCabang ?? '',
        'token': user.token ?? '',
        // Jika ingin aktifkan: 'hasDownline': user.hasDownline?.toString() ?? '',
        // Jika ingin aktifkan: 'foto': user.foto ?? '',
      };

      for (final entry in userMap.entries) {
        CookieManager.setCookie(entry.key, entry.value, remember: event.remember);
      }

      emit(LoginPreAuthenticate());
      authenticationBloc.add(LoggedIn(user: user, remember: event.remember));
      emit(LoginPostAuthenticate());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}

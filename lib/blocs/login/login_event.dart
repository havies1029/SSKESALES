part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final bool remember;

  const LoginButtonPressed({required this.username, required this.password, required this.remember});

  @override
  List<Object> get props => [username, password, remember];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password, remember: $remember }';
}

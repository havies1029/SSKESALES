part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final User user;
  final bool remember;

  const LoggedIn({required this.user, required this.remember});

  @override
  List<Object> get props => [user, remember];

  @override
  String toString() => 'LoggedIn { user: $user.username.toString(), remember: $remember }';
}

class LoggedOut extends AuthenticationEvent {}

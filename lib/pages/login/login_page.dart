import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';
import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/blocs/login/login_bloc.dart';
import 'package:esalesapp/pages/login/login_form.dart';
import 'package:esalesapp/pages/splash/splash_screen.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository,
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}

import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';

import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/blocs/login/login_bloc.dart';
import 'package:esalesapp/pages/login/login_form.dart';
import 'package:esalesapp/widgets//splash_screen.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  const LoginPage({super.key, required this.userRepository});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showSplash = true;

  // Callback dipanggil ketika animasi splash selesai.
  void _onSplashFinish() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        body: _showSplash
            ? SplashScreen(
          imageAsset: 'assets/images/jps-image.png',
          animationDuration: const Duration(seconds: 3),
          onFinish: _onSplashFinish,
        )
            : BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: widget.userRepository,
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}

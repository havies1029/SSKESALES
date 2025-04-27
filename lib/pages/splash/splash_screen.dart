import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/pages/home/home_page.dart';
import 'package:esalesapp/pages/login/login_page.dart';
import '../../repositories/user/user_repository.dart';
import '../../widgets/animation_helper.dart';

class SplashScreen extends StatefulWidget {
  final UserRepository userRepository;
  final String imageAsset;
  final Duration animationDuration;

  const SplashScreen({
    Key? key,
    required this.userRepository,
    required this.imageAsset,
    this.animationDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _progressAnimation;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = createAnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _logoScaleAnimation = createScaleAnimation(_controller);
    _textFadeAnimation = createFadeAnimation(_controller);
    _progressAnimation = createProgressAnimation(_controller);

    _controller.forward();
  }

  void _navigateBasedOnAuth(AuthenticationState state) {
    if (!mounted || _navigated) return;
    _navigated = true;

    Widget destination;
    if (state is AuthenticationAuthenticated) {
      destination = HomePage(
        userRepository: widget.userRepository,
        userid: 0,
        key: null,
      );
    } else {
      destination = LoginPage(
        userRepository: widget.userRepository,
      );
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated || state is AuthenticationUnauthenticated) {
          Future.delayed(widget.animationDuration, () {
            _navigateBasedOnAuth(state);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Image.asset(
                    widget.imageAsset,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GradientText(
                              'E-',
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF80B244), Color(0xFF3C592C)],
                              ),
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GradientText(
                              'Planner',
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFFEBA2B), Color(0xFFF57933)],
                              ),
                              style: const TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, child) {
                              return LinearProgressIndicator(
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                                value: _progressAnimation.value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(
      this.text, {
        Key? key,
        required this.gradient,
        required this.style,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

import 'package:esalesapp/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/onboard/onboard_page.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardMainPage extends StatefulWidget {
  const OnboardMainPage({super.key});

  @override
  State<OnboardMainPage> createState() => OnboardMainPageState();
}

class OnboardMainPageState extends State<OnboardMainPage> {

  @override
  Widget build(BuildContext context) {
    debugPrint("OnboardMainPage -> build");    

    return MobileDesignWidget(
      child: BlocProvider(
        create: (context) => OnBoardMenuCariBloc(),
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: const OnBoardPage(),
          ),
      ),
    );
  }

}

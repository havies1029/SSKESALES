import 'package:esalesapp/pages/onboard/onboard_page.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

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
      child: Scaffold(
          backgroundColor: Colors.grey[200],          
          body: const OnBoardPage(),
        ),
    );
  }

}

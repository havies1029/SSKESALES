import 'package:esalesapp/pages/timeline/expiredpolis_main.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class ExpiredPolisBasePage extends StatelessWidget {
  const ExpiredPolisBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileDesignWidget(child: ExpiredPolicyMainPage());
  }
}

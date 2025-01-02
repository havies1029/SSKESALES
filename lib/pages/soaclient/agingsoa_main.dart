import 'package:esalesapp/pages/soaclient/agingsoa_timeline.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class AgingSOAMainPage extends StatelessWidget {
  const AgingSOAMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        body: AgingSOATimelinePage(),
      ));
  }
}

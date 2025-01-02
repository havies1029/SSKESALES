import 'package:esalesapp/pages/soaclient/dnlist_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class DNListMainPage extends StatelessWidget {
  final String soaAgingId;
  final String titlePage;
  const DNListMainPage({super.key, required this.soaAgingId, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text(titlePage),
      ),
      body: DnlistPage(
        soaAgingId: soaAgingId,
      ),
    ));
  }
}

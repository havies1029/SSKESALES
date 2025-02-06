import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstrekan/rekancontactlist_list.dart';

class RekanContactListMainPage extends StatelessWidget {
  final String mrekanId;
  const RekanContactListMainPage({super.key, required this.mrekanId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RekanContactListPage(mrekanId: mrekanId),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstrekan/rekancari_list.dart';

class RekanCariMainPage extends StatelessWidget {
  final String rekanTypeId;
  const RekanCariMainPage({super.key, required this.rekanTypeId});

  @override
  Widget build(BuildContext context) {

    /*
    BlocProvider.of<RekanCariBloc>(context).add(RefreshRekanCariEvent(
        rekanTypeId: rekanTypeId, hal: 0, searchText: ""));
    */
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RekanCariPage(rekanTypeId: rekanTypeId),
    );
  }
}

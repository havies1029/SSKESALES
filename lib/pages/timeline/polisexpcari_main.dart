import 'package:esalesapp/blocs/timeline/polisexpcari_bloc.dart';
import 'package:esalesapp/pages/timeline/polisexpcari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolisExpCariMainPage extends StatelessWidget {
  final int severity;
  final String expgroupId;
  final String groupName;
  final String personalId;
  final String personalNama;
  const PolisExpCariMainPage(
      {super.key,
      required this.expgroupId,
      required this.groupName,
      required this.severity,
      required this.personalId,
      required this.personalNama});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Next Exp : $groupName'), 
            Text('Marketing : $personalNama')],
          ),
        ),
        body: BlocProvider(
          create: (context) => PolisExpCariBloc(),
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: PolisExpCariPage(
              expgroupId: expgroupId,
              personalId: personalId,
              severity: severity,
            ),
          ),
        ),
      ),
    );
  }
}

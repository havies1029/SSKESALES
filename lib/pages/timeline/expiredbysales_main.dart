import 'package:esalesapp/blocs/timeline/expiredbysales_bloc.dart';
import 'package:esalesapp/pages/timeline/expiredbysales_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpiredBySalesMainPage extends StatelessWidget {
  final int severity;
  final String expgroupId;
  final String groupName;
  const ExpiredBySalesMainPage({super.key, required this.expgroupId, 
    required this.groupName, required this.severity});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Next Exp : $groupName'),
        ),
        body: BlocProvider(
          create: (context) => ExpiredBySalesBloc(),
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            body: ExpiredBySalesPage(expgroupId: expgroupId, severity: severity, groupNama: groupName),
          ),
        ),
      ),
    );
  }
}

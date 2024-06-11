import 'package:esalesapp/blocs/mstjob/jobsalescari_bloc.dart';
import 'package:esalesapp/pages/mstjob/jobsalescari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobSalesCariMainPage extends StatelessWidget {
	const JobSalesCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            return JobSalesCariBloc();          },
          child: const JobSalesCariPage(),
        ),
      ),
    );
  }
}

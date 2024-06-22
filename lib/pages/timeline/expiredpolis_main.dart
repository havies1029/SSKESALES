import 'package:esalesapp/blocs/timeline/expiredgroupcari_bloc.dart';
import 'package:esalesapp/pages/timeline/expiredpolis_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpiredPolicyMainPage extends StatelessWidget {
	const ExpiredPolicyMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return BlocProvider(      
          create: (context) => ExpiredGroupCariBloc(),
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            body: const ExpiredPolisTimelinePage(),
          ),
        );
	}
}

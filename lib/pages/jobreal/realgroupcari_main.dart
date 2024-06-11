import 'package:esalesapp/blocs/jobreal/realgroupcari_bloc.dart';
import 'package:esalesapp/pages/jobreal/realgroupcari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealGroupCariMainPage extends StatelessWidget {
	const RealGroupCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            return RealGroupCariBloc();          
          },
          child: const RealGroupCariPage(),
        ),
      ),
    );
  }
}

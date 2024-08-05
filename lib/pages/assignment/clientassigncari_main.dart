import 'package:esalesapp/blocs/assignment/clientassigncari_bloc.dart';
import 'package:esalesapp/pages/assignment/clientassigncari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientAssignCariMainPage extends StatelessWidget {
  const ClientAssignCariMainPage(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: BlocProvider(
          create: (context) => ClientAssignCariBloc(),
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: const ClientAssignCariPage(),
          ),
        ),
    );
  }
}

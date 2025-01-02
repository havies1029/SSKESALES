import 'package:esalesapp/blocs/home/home_bloc.dart';
import 'package:esalesapp/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:esalesapp/blocs/timeline/expiredgroupcari_bloc.dart';
import 'package:esalesapp/pages/timeline/expiredpolis_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpiredPolicyMainPage extends StatefulWidget {
  const ExpiredPolicyMainPage({super.key});

  @override
  State<ExpiredPolicyMainPage> createState() => ExpiredPolicyMainPageState();
}

class ExpiredPolicyMainPageState extends State<ExpiredPolicyMainPage> {  
  late OnBoardMenuCariBloc onBoardMenuCariBloc;

  @override
  Widget build(BuildContext context) {
    onBoardMenuCariBloc = BlocProvider.of<OnBoardMenuCariBloc>(context);
    return BlocProvider(
      create: (context) => ExpiredGroupCariBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: const ExpiredPolisTimelinePage(),
        bottomNavigationBar: Container(
          height: 70,
          color: Colors.black12,
          child: InkWell(
            onTap: () {
                BlocProvider.of<HomeBloc>(context).add(
                  onBoardMenuCariBloc.state.hasPassedBriefing?                  
                  JobRealCariPageActiveEvent():
                  BriefingPageActiveEvent());            
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    onBoardMenuCariBloc.state.hasPassedBriefing?Icons.home:Icons.people_alt,
                    size: 35,
                    color: Colors.black,
                  ),
                  Text(
                    onBoardMenuCariBloc.state.hasPassedBriefing?"Finished Tasks":"Briefing",
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

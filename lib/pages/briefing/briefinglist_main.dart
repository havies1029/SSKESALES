import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/blocs/home/home_bloc.dart';
import 'package:esalesapp/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:esalesapp/pages/briefing/briefinglist_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BriefingListMainPage extends StatefulWidget {
  const BriefingListMainPage({super.key});

  @override
  BriefingListMainPageState createState() => BriefingListMainPageState();
}

class BriefingListMainPageState extends State<BriefingListMainPage> {
  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: const BriefinglistPage(),
        bottomNavigationBar: BlocConsumer<OnBoardMenuCariBloc, OnBoardMenuCariState>(
          builder: (context, state) {
            return state.hasPassedBriefing
                ? Container(
          height: 70,
          color: Colors.black12,
          child: InkWell(
            onTap: () {
              //debugPrint("hasPassBriefing ? : ${BlocProvider.of<OnBoardMenuCariBloc>(context).state.hasPassedBriefing}");
                
              if (BlocProvider.of<OnBoardMenuCariBloc>(context)
                  .state
                  .hasPassedBriefing) {
                BlocProvider.of<HomeBloc>(context)
                    .add(JobRealCariPageActiveEvent());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Silakan input hasil briefing."),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: 35,
                    color: Colors.black,
                  ),
                  Text(
                    "Tasks",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ): 
        Container(
                    height: 70,
                    color: Colors.black12,
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut());
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.logout,
                              size: 35,
                              color: Colors.black,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          listener: (BuildContext context, state) {},
        ),
      ),
    );
  }
}

import 'package:esalesapp/blocs/home/home_bloc.dart';
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
  

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ExpiredGroupCariBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: const ExpiredPolisTimelinePage(),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black12,
          child: InkWell(
            // ignore: avoid_print
            onTap: () {

                BlocProvider.of<HomeBloc>(context).add(JobRealCariPageActiveEvent());
              //});
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
                    'Finished Tasks',
                    style: TextStyle(color: Colors.black),
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

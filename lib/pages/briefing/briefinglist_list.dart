
import 'package:esalesapp/blocs/briefing/briefinginfo_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/briefing/briefinglist_model.dart';
import 'package:esalesapp/pages/jobreal/jobrealcrud_main.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/briefing/briefinglist_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

part 'briefinglist_list_widget.dart';

class BriefinglistPage extends StatefulWidget {
  const BriefinglistPage({super.key});

  @override
  BriefinglistPageState createState() => BriefinglistPageState();
}

class BriefinglistPageState extends State<BriefinglistPage> {
  late BriefinglistBloc briefinglistBloc;
  late BriefingInfoBloc briefingInfoBloc;
  late JobRealGlobalCubit jobRealGlobalCubit;
  late OnBoardMenuCariBloc onBoardMenuCariBloc;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("BriefinglistPageState #10");
    briefinglistBloc = BlocProvider.of<BriefinglistBloc>(context);
    briefingInfoBloc = BlocProvider.of<BriefingInfoBloc>(context);
    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);    
    onBoardMenuCariBloc = BlocProvider.of<OnBoardMenuCariBloc>(context);

    //debugPrint("onBoardMenuCariBloc.state.hasPassedBriefing : ${onBoardMenuCariBloc.state.hasPassedBriefing}");

    return MultiBlocListener(
      listeners: [
        
        BlocListener<BriefingInfoBloc, BriefingInfoState>(
            listener: (context, state) {
          //debugPrint("BriefinglistPageState #40");
          if (state.hasPassedBriefing) {
            debugPrint("state.hasPassedBriefing : ${state.hasPassedBriefing}");
            onBoardMenuCariBloc.add(SetHasPassedBriefingPageEvent(
                hasPassedBriefing: state.hasPassedBriefing));
          }
        }),        
        BlocListener<JobRealCrudBloc, JobRealCrudState>(
            listenWhen: (previous, current) {
          //debugPrint("BriefinglistPageState #60");
          return (current.isSaved);
        }, listener: (context, state) {
          //debugPrint("BriefinglistPageState #70");
          if (state.isSaved) {
            //debugPrint("BriefinglistPageState #80");
            refreshList();
          }
        }),
      ],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Date : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                style: MyText.bodyLarge(context)!.copyWith(
                  color: Colors.transparent,
                  shadows: [
                    const Shadow(color: MyColors.grey_80, offset: Offset(0, -5))
                  ],
                  decoration: TextDecoration.underline,
                  decorationColor: MyColors.grey_80,
                  decorationThickness: 2.0,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            Container(height: 10),
            buildList(),
          ],
        ),
      ),
    );
  }

  void refreshData() {
    briefinglistBloc.add(GetJobCatGroupOtherRecordEvent());
    refreshList();
  }

  void refreshList() {
    briefinglistBloc.add(RefreshBriefinglistEvent());
    briefingInfoBloc.add(CekStatusBriefingHariIniEvent());
  }

  Widget buildList() {
    return const Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[BriefinglistListWidget()],
    ));
  }
}

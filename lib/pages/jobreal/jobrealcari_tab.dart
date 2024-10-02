import 'package:esalesapp/blocs/jobreal/jobrealbtnfilter_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealtab_bloc.dart';
import 'package:esalesapp/common/common.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobRealCariTabPage extends StatefulWidget {
  final bool readOnly;
  final String personId;
  const JobRealCariTabPage(
      {super.key, required this.personId, required this.readOnly});

  @override
  JobRealCariTabPageState createState() => JobRealCariTabPageState();
}

class JobRealCariTabPageState extends State<JobRealCariTabPage> 
    with TickerProviderStateMixin {
  //late JobRealTabBloc jobRealTabBloc;
  //late TabController tabController;
  late JobRealCariBloc jobRealCariBloc;
  late JobRealGlobalCubit jobRealGlobalCubit;
  late JobRealBtnFilterCubit jobRealBtnFilterCubit;
  //List<Widget> listTab = [];
  //List<Widget> listChild = <Widget>[];
  //final List<Color> colorCollection = <Color>[];
  //List<ComboJobcatgroupModel> listJobCatGroup = [];

  @override
  void initState() {
    debugPrint("JobRealCariTabPageState -> initState #10");

    super.initState();

    /*
    Future.delayed(const Duration(milliseconds: 500), () {
      debugPrint("JobRealCariTabPageState -> initState -> Future.delayed");
      refreshData();
    });
    */
    
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("JobRealCariTabPageState -> build");
    //jobRealTabBloc = BlocProvider.of<JobRealTabBloc>(context);
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);
    jobRealBtnFilterCubit = BlocProvider.of<JobRealBtnFilterCubit>(context);

    return BlocConsumer<JobRealTabBloc, JobRealTabState>(
        listener: (context, state) {
      if (state.status == ListStatus.success) {
        debugPrint("JobRealTabState #10 => listeners ${state.status}");
        //listChild = [];
        //listJobCatGroupId = [];

        /*
        state.items.asMap().forEach((idx, item) {
          debugPrint("item.groupNama : ${item.groupNama}");
          debugPrint("item.hasIndex : ${item.hasIndex}");
          debugPrint("idx : $idx");
          //listJobCatGroupId[idx] = item.mjobcatgroupId;
          listJobCatGroup.add(item);
          listTab.add(Text(item.groupNama));
          colorCollection.add(getTabColor(item.urutan));
        });
        */

        //tabController = TabController(vsync: this, length: state.items.length);

        /*
        tabController.addListener(() {
          //debugPrint("Tab Change ${tabController.index}");
          selectedTabEvent(listJobCatGroup[tabController.index]);
          //debugPrint("listJobCatGroup[tabController.index].hasIndex : ${listJobCatGroup[tabController.index].hasIndex}");
        });
        */

        /*
        if (state.listJobCatGroup!.isNotEmpty) {
          debugPrint("listJobCatGroup.isNotEmpty xx");
          selectedTabEvent(state.listJobCatGroup![0]);
        }
        */
        
      }
    }, builder: (context, state) {
      if (state.status == ListStatus.success) {
        TabController tabController =
            TabController(vsync: this, length: state.items.length);
        tabController.addListener(() {
          //debugPrint("Tab Change ${tabController.index}");
          selectedTabEvent(state.listJobCatGroup![tabController.index]);
          //debugPrint("listJobCatGroup[tabController.index].hasIndex : ${listJobCatGroup[tabController.index].hasIndex}");
        });

        return JobRealCariTabWidget(
            tabController: tabController,
            readOnly: widget.readOnly,
            personId: widget.personId,
            listTab: state.listTab!,
            listJobCatGroup: state.listJobCatGroup!,
            colorCollection: state.colorCollection!);
      } else {
        return const Center(
          child: LoadingIndicator(),
        );
      }
    });
  }

  void selectedTabEvent(ComboJobcatgroupModel selectedTab) {
    debugPrint("selectedTabEvent #10");

    jobRealGlobalCubit.setSelectedJobCatGroup(selectedTab);

    debugPrint(
        "jobRealBtnFilterCubit.state.filterDoc : ${jobRealBtnFilterCubit.state.filterDoc}");

    jobRealCariBloc.add(RefreshJobRealCariEvent(
        hal: 0,
        searchText: "",
        filterDoc: jobRealBtnFilterCubit.state.filterDoc,
        personId: widget.personId,
        jobCatGroupId: selectedTab.mjobcatgroupId));
  }

  /*
  Future<void> refreshData() async {
    debugPrint("JobRealCariTabPage -> refreshData");
    jobRealTabBloc.add(RefreshJobRealTabEvent(personId: widget.personId));
  }
  */
  

  /*
  Color getTabColor(int urutan) {
    Color color;

    switch (urutan) {
      case 10:
        color = const Color(0xFF0F8644);
        break;
      case 20:
        color = const Color(0xFF8B1FA9);
        break;
      case 30:
        color = const Color(0xFFD20100);
        break;
      case 40:
        color = const Color(0xFFFC571D);
        break;
      case 50:
        color = const Color(0xFF36B37B);
        break;
      case 60:
        color = const Color(0xFF01A1EF);
        break;
      case 70:
        color = const Color(0xFF3D4FB5);
        break;
      case 80:
        color = const Color(0xFFE47C73);
        break;
      case 90:
        color = const Color(0xFF636363);
        break;
      case 100:
        color = const Color(0xFF0A8043);
        break;
      default:
        color = const Color(0xff443a49);
    }

    return color;
  }
  */
}

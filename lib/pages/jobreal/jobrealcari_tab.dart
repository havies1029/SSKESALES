import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealtab_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab_container/tab_container.dart';

class JobRealCariTabPage extends StatefulWidget {
  final bool readOnly;
  final String personId;
  const JobRealCariTabPage(
      {super.key, required this.personId, required this.readOnly});

  @override
  JobRealCariTabPageState createState() => JobRealCariTabPageState();
}

class JobRealCariTabPageState extends State<JobRealCariTabPage>
    with SingleTickerProviderStateMixin {
  late JobRealTabBloc jobRealTabBloc;
  late TabController tabController;
  late JobRealCariBloc jobRealCariBloc;
  late JobRealGlobalCubit jobRealGlobalCubit;
  List<Widget> listTab = [];
  //List<Widget> listChild = <Widget>[];
  final List<Color> colorCollection = <Color>[];
  List<ComboJobcatgroupModel> listJobCatGroup = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    jobRealTabBloc = BlocProvider.of<JobRealTabBloc>(context);
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);

    return BlocConsumer<JobRealTabBloc, JobRealTabState>(
      builder: (context, state) {
        if (state.status == ListStatus.success) {
          return TabContainer(
            controller: tabController,
            tabEdge: TabEdge.bottom,
            tabsStart: 0.1,
            tabsEnd: 0.9,
            tabMaxLength: 100,
            borderRadius: BorderRadius.circular(10),
            tabBorderRadius: BorderRadius.circular(10),
            childPadding: const EdgeInsets.only(
                bottom: 7.0, top: 1.0, left: 2.0, right: 2.0),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
            unselectedTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
            colors: colorCollection,
            tabs: listTab,
            //children: listChild,
            child: JobRealCariPage(
              personId: widget.personId,
              readOnly: widget.readOnly,
              //jobCatGroupId:listJobCatGroup[tabController.index].mjobcatgroupId, 
              selectedJobCatGroup: listJobCatGroup[0],
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No Data Available!!',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
      },
      buildWhen: (previous, current) {
        return (current.status == ListStatus.success);
      },
      listener: (context, state) {
        if (state.status == ListStatus.success) {
          //listChild = [];
          //listJobCatGroupId = [];

          state.items.asMap().forEach((idx, item) {
            debugPrint("item.groupNama : ${item.groupNama}");
            debugPrint("item.hasIndex : ${item.hasIndex}");
            debugPrint("idx : $idx");
            //listJobCatGroupId[idx] = item.mjobcatgroupId;
            listJobCatGroup.add(item);
            listTab.add(Text(item.groupNama));
            colorCollection.add(getTabColor(item.urutan));
            /*
            listChild.add(JobRealCariPage(
              personId: widget.personId,
              readOnly: widget.readOnly,
              //jobCatGroupId: item.mjobcatgroupId, 
              selectedJobCatGroup: null,
            ));
            */
          });

          tabController =
              TabController(vsync: this, length: state.items.length);

          tabController.addListener(() {
            debugPrint("Tab Change ${tabController.index}");
            selectedTabEvent(listJobCatGroup[tabController.index]);
            debugPrint(
                "listJobCatGroup[tabController.index].hasIndex : ${listJobCatGroup[tabController.index].hasIndex}");
          });
          if (listJobCatGroup.isNotEmpty) {
            debugPrint("listJobCatGroup.isNotEmpty : ${listJobCatGroup.isNotEmpty}");
            selectedTabEvent(listJobCatGroup[0]);
          }
        }
      },
    );
  }

  void selectedTabEvent(ComboJobcatgroupModel selectedTab) {
    jobRealGlobalCubit.setSelectedJobCatGroup(selectedTab);

    jobRealCariBloc.add(RefreshJobRealCariEvent(
        hal: 0,
        searchText: "",
        filterDoc: jobRealCariBloc.state.filterDoc,
        personId: widget.personId,
        jobCatGroupId: selectedTab.mjobcatgroupId));
  }

  void refreshData() {
    //debugPrint("JobRealCariTabPage -> refreshData");
    jobRealTabBloc.add(RefreshJobRealTabEvent(personId: widget.personId));
  }

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
}

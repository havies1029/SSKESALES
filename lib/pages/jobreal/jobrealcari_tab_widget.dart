import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_list.dart';
import 'package:flutter/material.dart';
import 'package:tab_container/tab_container.dart';

class JobRealCariTabWidget extends StatefulWidget {
  final bool readOnly;
  final String personId;
  final TabController tabController;
  final List<Widget> listTab;
  final List<ComboJobcatgroupModel> listJobCatGroup;
  final List<Color> colorCollection;

  const JobRealCariTabWidget(
      {super.key,
      required this.tabController,
      required this.readOnly,
      required this.personId,
      required this.listTab,
      required this.listJobCatGroup,
      required this.colorCollection});

  @override
  JobRealCariTabWidgetState createState() => JobRealCariTabWidgetState();
}

class JobRealCariTabWidgetState extends State<JobRealCariTabWidget>
{
  List<Color> colorCollection = <Color>[];
  List<ComboJobcatgroupModel> listJobCatGroup = [];
  List<Widget> listTab = [];

  @override
  Widget build(BuildContext context) {
    
    listJobCatGroup = widget.listJobCatGroup;
    listTab = widget.listTab;
    colorCollection = widget.colorCollection;

    return TabContainer(
      controller: widget.tabController,
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
  }

}

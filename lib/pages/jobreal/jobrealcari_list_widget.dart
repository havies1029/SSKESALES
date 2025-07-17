import 'package:esalesapp/blocs/jobreal/jobrealbtnfilter_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/jobreal/jobtimelinenonsppa_main.dart';
import 'package:esalesapp/pages/jobreal/sppacari_list_main.dart';
import 'package:esalesapp/pages/polis/poliscari_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_tile_widget.dart';

class JobRealCariListWidget extends StatefulWidget {
  final bool readOnly;
  final String personId;
  final String searchText;
  const JobRealCariListWidget({
    super.key,
    required this.searchText,
    required this.personId,
    required this.readOnly,
  });

  @override
  JobRealCariListWidgetState createState() => JobRealCariListWidgetState();
}

class JobRealCariListWidgetState extends State<JobRealCariListWidget> {
  late JobRealCariBloc jobRealCariBloc;
  late JobRealCrudBloc jobRealCrudBloc;
  late JobRealGlobalCubit jobRealGlobalCubit;
  late JobRealBtnFilterCubit jobRealBtnFilterCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);
    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);
    jobRealBtnFilterCubit = BlocProvider.of<JobRealBtnFilterCubit>(context);
    //selectedJobCatGroup = widget.selectedJobCatGroup;
    return MultiBlocListener(
      listeners: [
        BlocListener<JobRealGlobalCubit, JobRealGlobalState>(
            listenWhen: (previous, current) {
          return (previous.selectedJobCatGroup != current.selectedJobCatGroup);
        }, listener: (context, state) {
          //selectedJobCatGroup = state.selectedJobCatGroup;
        }),
      ],
      child: BlocConsumer<JobRealCariBloc, JobRealCariState>(
          builder: (context, state) {
        if (state.status == ListStatus.success) {
          //debugPrint("selectedJobCatGroup?.hasIndex : ${selectedJobCatGroup?.hasIndex}");
          return state.items.isNotEmpty
              ? Flexible(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      itemCount: state.items.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          padding: const EdgeInsets.all(0.2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Slidable(
                              startActionPane: ActionPane(
                                  extentRatio: 0.8,
                                  //openThreshold: 0.8,
                                  motion: const BehindMotion(),
                                  children: [
                                    widget.readOnly
                                        ? Container()
                                        : SlidableAction(
                                            onPressed: (context) {
                                              jobRealCariBloc.add(
                                                  JobRealDuplicateEvent(
                                                      recordId: state
                                                          .items[index]
                                                          .jobreal1Id));
                                            },
                                            backgroundColor: Colors.deepPurple,
                                            icon: Icons.copy,
                                            label: "Copy",
                                          ),
                                    widget.readOnly
                                        ? Container()
                                        : (jobRealGlobalCubit
                                                    .state
                                                    .selectedJobCatGroup
                                                    .hasIndex &&
                                                (state.items[index].jobIdx >
                                                    0) &&
                                                (state.items[index].totalJob >
                                                    state.items[index].jobIdx))
                                            ? SlidableAction(
                                                onPressed: (context) {
                                                  jobRealCariBloc.add(
                                                      JobRealMove2NextFlowEvent(
                                                          recordId: state
                                                              .items[index]
                                                              .jobreal1Id));
                                                },
                                                backgroundColor: Colors.green,
                                                icon: Icons.next_plan,
                                                label: "Next",
                                              )
                                            : Container(),
                                    SlidableAction(
                                      onPressed: (context) {
                                        state.items[index].jobCatDocTypeId == "sppa" ?
                                        showDialogPickSPPA(
                                            context,
                                            state.items[index].jobreal1Id,
                                            jobRealGlobalCubit.state
                                                .selectedJobCatGroup.groupNama,
                                            state.items[index].customerNama) :
                                        showDialogJobCatTimeline(context, 
                                          state.items[index].jobreal1Id, 
                                          jobRealGlobalCubit.state
                                                .selectedJobCatGroup.groupNama,
                                          state.items[index].customerNama);
                                      },
                                      backgroundColor: Colors.yellow,
                                      icon: Icons.copy,
                                      label: "Timeline",
                                    ),
                                  ]),
                              endActionPane: (state.items[index].isConfirmed ||
                                      widget.readOnly)
                                  ? ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              jobRealCariBloc.add(
                                                  LihatJobRealCariEvent(
                                                      recordId: state
                                                          .items[index]
                                                          .jobreal1Id));
                                            },
                                            backgroundColor: Colors.grey,
                                            icon: Icons.read_more,
                                            label: "View",
                                          )
                                        ])
                                  : ActionPane(
                                      motion: const BehindMotion(),
                                      children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              jobRealCariBloc.add(
                                                  UbahJobRealCariEvent(
                                                      recordId: state
                                                          .items[index]
                                                          .jobreal1Id));
                                            },
                                            backgroundColor: Colors.green,
                                            icon: Icons.edit,
                                            label: "Edit",
                                          ),
                                          SlidableAction(
                                            onPressed: (context) {
                                              showDialogHapus(state
                                                  .items[index].jobreal1Id);
                                            },
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete,
                                            label: "Delete",
                                          ),
                                        ]),
                              child: JobRealCariTileWidget(
                                catName: state.items[index].catName ?? '',
                                hasil: state.items[index].hasil,
                                jobNama: state.items[index].jobNama ?? '',
                                jobreal1Id: state.items[index].jobreal1Id,
                                materi: state.items[index].materi,
                                mediaNama: state.items[index].mediaNama ?? '',
                                picName: state.items[index].picName,
                                realJam: state.items[index].realJam,
                                realTgl: state.items[index].realTgl,
                                customerNama: state.items[index].customerNama,
                                isConfirmed: state.items[index].isConfirmed,
                                catGroupName:
                                    state.items[index].catGroupName ?? "",
                                rdPartyName: state.items[index].rdPartyName??"",
                                projectNama: state.items[index].projectNama,
                                jobCatGroupCode: state.items[index].jobCatGroupCode,
                                needMoM: state.items[index].needMoM,
                              )),
                        );
                      }),
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: Text(
                      'No Data Available!!',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
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
      }, buildWhen: (previous, current) {
        return (current.status == ListStatus.success);
      }, listener: (context, state) {
        if (state.requestToRefresh) {
          jobRealCariBloc.add(RefreshJobRealCariEvent(
              personId: widget.personId,
              jobCatGroupId:
                  jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId,
              hal: 0,
              searchText: widget.searchText,
              filterDoc: jobRealBtnFilterCubit.state.filterDoc));
        }
      }),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      jobRealCariBloc.add(FetchJobRealCariEvent(
          searchText: widget.searchText,
          jobCatGroupId:
              jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId,
          hal: jobRealCariBloc.state.hal,
          filterDoc: jobRealBtnFilterCubit.state.filterDoc));
    }
  }

  onHapusFunction(String recordId) {
    jobRealCrudBloc.add(JobRealCrudHapusEvent(recordId: recordId));
  }

  void showDialogHapus(String recordId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowDialogHapusWidget(
              onHapusFunction: onHapusFunction, recordId: recordId);
        }).then((value) {
      jobRealCariBloc.add(CloseDialogJobRealCariEvent());
    });
  }

  void showDialogPickSPPA(BuildContext context, String jobRealId,
      String titlePage, String custName) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {        
        return SppaCariListMainPage(jobRealId: jobRealId, titlePage: titlePage, custName: custName);
      }),
    );
  }

  void showDialogJobCatTimeline(BuildContext context, String jobRealId,
      String titlePage, String custName) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {        
        return JobTimelineNonSppaMainPage(jobRealId: jobRealId, titlePage: titlePage, custName: custName);
      }),
    );
  }
}

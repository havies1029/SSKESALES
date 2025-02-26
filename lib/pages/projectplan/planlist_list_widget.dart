import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/blocs/projectplan/planinfo_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/models/projectplan/planlist_model.dart';
import 'package:esalesapp/pages/jobreal/jobrealcrud_main.dart';
import 'package:esalesapp/pages/projectplan/planlist_tile_jobreal_widget.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/projectplan/planlist_bloc.dart';
import 'package:esalesapp/blocs/projectplan/plancrud_bloc.dart';
import 'package:esalesapp/pages/projectplan/planlist_tile_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:timelines_plus/timelines_plus.dart';

class PlanListListWidget extends StatefulWidget {
  final String projectId;
  const PlanListListWidget({super.key, required this.projectId});

  @override
  PlanListListWidgetState createState() => PlanListListWidgetState();
}

class PlanListListWidgetState extends State<PlanListListWidget> {
  late JobRealCariBloc jobRealCariBloc;
  late JobRealCrudBloc jobRealCrudBloc;
  late JobRealFotoBloc jobRealFotoBloc;
  late PlanListBloc planListBloc;
  late PlanCrudBloc planCrudBloc;
  late PlanInfoBloc planInfoBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData();
    });
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
    jobRealFotoBloc = BlocProvider.of<JobRealFotoBloc>(context);
    planListBloc = BlocProvider.of<PlanListBloc>(context);
    planCrudBloc = BlocProvider.of<PlanCrudBloc>(context);
    planInfoBloc = BlocProvider.of<PlanInfoBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<JobRealCrudBloc, JobRealCrudState>(
            listenWhen: (previous, current) {
          return (previous.isSaved != current.isSaved);
        }, listener: (context, state) {
          debugPrint(
              "BlocListener<JobRealCrudBloc state.isSaved : ${state.isSaved}");
          if (state.isSaved) {
            refreshData();
          }
        }),
      ],
      child: BlocConsumer<PlanListBloc, PlanListState>(
          builder: (context, state) {
            if (state.status == ListStatus.success) {
              return state.items.isNotEmpty
                  ? Timeline.tileBuilder(
                      padding: const EdgeInsets.all(8.0),
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: const Color.fromARGB(255, 152, 152, 152),
                        indicatorTheme: const IndicatorThemeData(
                          position: 0,
                          size: 20.0,
                        ),
                        connectorTheme: const ConnectorThemeData(
                          thickness: 2.5,
                        ),
                      ),
                      builder: TimelineTileBuilder.connected(
                        connectionDirection: ConnectionDirection.before,
                        indicatorBuilder: (_, index) {
                          if (state.items[index].isConfirmed??false) {
                            return const DotIndicator(
                              color: Color(0xff66c97f),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12.0,
                              ),
                            );
                          } else {
                            return const OutlinedDotIndicator(
                              borderWidth: 2.5,
                            );
                          }
                        },
                        connectorBuilder: (_, index, ___) => SolidLineConnector(
                          color: (state.items[index].isConfirmed??false)
                              ? const Color(0xff66c97f)
                              : null,
                        ),
                        contentsAlign: ContentsAlign.basic,
                        contentsBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                    state.items[index]
                                                            .planStart ??
                                                        DateTime.now()),
                                                style:
                                                    MyText.titleLarge(context)!
                                                        .copyWith(
                                                            color: MyColors
                                                                .grey_95)),
                                          ],
                                        ),
                                      ),
                                      //const Spacer(),
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                            '[${state.items[index].urutan}/${state.items[index].totalJob}]',
                                            style: MyText.titleLarge(context)!
                                                .copyWith(
                                                    color: MyColors.grey_95)),
                                      ),
                                    ],
                                  ),
                                ),
                                state.items[index].jobreal1Id?.isEmpty ?? true
                                    ? Slidable(
                                        endActionPane: ActionPane(
                                          motion: BehindMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                showDialogViewData(
                                                    state.items[index], index, "tambah");
                                              },
                                              backgroundColor: Colors.green,
                                              icon: Icons.run_circle,
                                              label: "Release task",
                                            ),
                                          ],
                                        ),
                                        child: PlanListTileWidget(
                                          jobNama: state.items[index].jobNama,
                                          planDurasi:
                                              state.items[index].planDurasi,
                                          planFinish:
                                              state.items[index].planFinish ??
                                                  DateTime.now(),
                                          planStart:
                                              state.items[index].planStart ??
                                                  DateTime.now(),
                                          plan1Id: state.items[index].plan1Id,
                                          urutan: state.items[index].urutan,
                                        ),
                                      )
                                    : Slidable(
                                        endActionPane: ((state
                                                    .items[index].isConfirmed ??
                                                false) || (AppData.personId != state.items[index].personalId))
                                            ? ActionPane(
                                                motion: const BehindMotion(),
                                                children: [
                                                    SlidableAction(
                                                      onPressed: (context) {
                                                        showDialogViewData(
                                                            state.items[index],
                                                            index, "lihat");
                                                      },
                                                      backgroundColor:
                                                          Colors.grey,
                                                      icon: Icons.read_more,
                                                      label: "View",
                                                    )
                                                  ])
                                            : ActionPane(
                                                motion: BehindMotion(),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (context) {
                                                      showDialogViewData(
                                                          state.items[index],
                                                          index, "ubah");
                                                    },
                                                    backgroundColor:
                                                        Colors.green,
                                                    icon: Icons.edit,
                                                    label: "Edit",
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (context) {
                                                      showDialogHapusJobReal(
                                                          state.items[index]
                                                              .jobreal1Id!);
                                                    },
                                                    backgroundColor: Colors.red,
                                                    icon: Icons.delete,
                                                    label: "Delete",
                                                  ),
                                                ],
                                              ),
                                        child: PlanListTileJobRealWidget(
                                            hasil:
                                                state.items[index].hasil ?? "",
                                            jobreal1Id:
                                                state.items[index].jobreal1Id ??
                                                    "",
                                            materi:
                                                state.items[index].materi ?? "",
                                            picName:
                                                state.items[index].picName ??
                                                    "",
                                            realTgl:
                                                state.items[index].realTgl ??
                                                    DateTime.now(),
                                            jobNama: state.items[index].jobNama,
                                            mediaNama:
                                                state.items[index].mediaNama ??
                                                    "",
                                            rdPartyName: state
                                                    .items[index].rdPartyName ??
                                                "",
                                            isConfirmed: state
                                                    .items[index].isConfirmed ??
                                                false,
                                            officerName: state.items[index].personalNama ?? ""),
                                      )
                              ],
                            )),
                        itemCount: state.items.length,
                      ),
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
          },
          buildWhen: (previous, current) {
            return (current.status == ListStatus.success);
          },
          listener: (context, state) {}),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      planListBloc.add(FetchPlanListEvent());
    }
  }

  onHapusFunction(String recordId) {
    planCrudBloc.add(PlanCrudHapusEvent(recordId: recordId));
  }

  void showDialogHapus(String recordId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowDialogHapusWidget(
              onHapusFunction: onHapusFunction, recordId: recordId);
        }).then((value) {
      planListBloc.add(CloseDialogPlanListEvent());
    });
  }

  void refreshData() {
    planListBloc.add(RefreshPlanListEvent(projectId: widget.projectId));
  }

  void refreshFormJobReal() {
    jobRealFotoBloc.add(ResetStateJobRealFotoEvent());
  }

  void showDialogViewData(PlanListModel item, int selectedIndex, String viewMode) {    
    //refreshFormJobReal();
    resetFormState();
    planInfoBloc.add(SetSelectedItemPlanInfoEvent(selectedItem: item));
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        jobRealCrudBloc.add(JobRealCrudPreOpenEvent(viewmode: viewMode));
        return JobRealCrudMainPage(
          viewMode: viewMode,
          recordId: item.jobreal1Id ?? "",
          isBriefingHarianMode: false,
          isSOAClientMode: false,
          isProjectMode: true,
        );
      }),
    ).then((value) {
      jobRealCariBloc.add(CloseDialogJobRealCariEvent());
    });
  }

  onHapusJobRealFunction(String recordId) {
    jobRealCrudBloc.add(JobRealCrudHapusEvent(recordId: recordId));
  }

  void showDialogHapusJobReal(String recordId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowDialogHapusWidget(
              onHapusFunction: onHapusJobRealFunction, recordId: recordId);
        }).then((value) {
      planListBloc.add(CloseDialogPlanListEvent());
    });
  }

  void resetFormState() {
    debugPrint("PlanListListWidget -> resetFormState #10");

    jobRealCrudBloc.add(JobRealCrudResetStateEvent());
    BlocProvider.of<JobReal2CariBloc>(context)
        .add(ResetStateJobReal2CariEvent());
    BlocProvider.of<JobReal3CariBloc>(context)
        .add(ResetStateJobReal3CariEvent());
    BlocProvider.of<JobRealFotoBloc>(context).add(ResetStateJobRealFotoEvent());
    BlocProvider.of<JobReal2GridBloc>(context)
        .add(ResetStateJobReal2ListEvent());
    BlocProvider.of<JobReal3GridBloc>(context)
        .add(ResetStateJobReal3ListEvent());
  }
}

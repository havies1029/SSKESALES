import 'package:esalesapp/pages/jobreal/jobtimeline_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/jobreal/sppa4timelinecari_bloc.dart';
import 'package:esalesapp/pages/jobreal/sppacari_tile_widget.dart';
import 'package:esalesapp/models/jobreal/sppacari_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SppaCariListWidget extends StatefulWidget {
  final String jobRealId;
  final String searchText;
  const SppaCariListWidget(
      {super.key, required this.searchText, required this.jobRealId});

  @override
  SppaCariListWidgetState createState() => SppaCariListWidgetState();
}

class SppaCariListWidgetState extends State<SppaCariListWidget> {
  late Sppa4TimelineCariBloc sppaCariBloc;
  List<SppaCariModel> sppaCari = [];
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
    sppaCariBloc = BlocProvider.of<Sppa4TimelineCariBloc>(context);
    return BlocConsumer<Sppa4TimelineCariBloc, SppaCariState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            if (!state.hasReachedMax) {
              sppaCari.addAll(state.items);
            }

            return state.items.isNotEmpty
                ? Flexible(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        itemCount: state.items.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              padding: const EdgeInsets.all(0.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Slidable(
                                startActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          debugPrint("state.items[index].polisId ${state.items[index].polisId}");
                                          showDialogSPPATimeline(
                                              context,
                                              widget.jobRealId,
                                              state.items[index].sppaNo,
                                              state.items[index].polisId);
                                        },
                                        backgroundColor: Colors.yellow,
                                        icon: Icons.copy,
                                        label: "Timeline",
                                      ),
                                    ]),
                                child: SppaCariTileWidget(
                                  periodeAkhir: state.items[index].periodeAkhir,
                                  periodeAwal: state.items[index].periodeAwal,
                                  sppaNo: state.items[index].sppaNo,
                                  lastTask: state.items[index].lastTask,
                                  jobIndex: state.items[index].jobIndex,
                                  totalJob: state.items[index].totalJob,
                                  jobCount: state.items[index].jobCount,
                                  cob: state.items[index].cob,
                                ),
                              ),
                            )),
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
        listener: (context, state) {});
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      sppaCariBloc.add(const FetchSppaCariEvent());
    }
  }

  void showDialogSPPATimeline(
      BuildContext context, String jobRealId, String sppaNo, String polisId) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return JobTimelineMainPage(
          jobRealId: jobRealId,
          sppaNo: sppaNo,
          polisId: polisId,
        );
      }),
    );
  }
}

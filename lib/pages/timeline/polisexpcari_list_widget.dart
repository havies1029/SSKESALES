import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/timeline/polisexpcari_bloc.dart';
import 'package:esalesapp/pages/timeline/polisexpcari_tile_widget.dart';
import 'package:esalesapp/models/timeline/polisexpcari_model.dart';

class PolisExpCariListWidget extends StatefulWidget {
  final int severity;
  final String expgroupId;
  final String personalId;
  final String searchText;
  const PolisExpCariListWidget({
    super.key,
    required this.searchText,
    required this.expgroupId,
    required this.severity,
    required this.personalId,
  });

  @override
  PolisExpCariListWidgetState createState() => PolisExpCariListWidgetState();
}

class PolisExpCariListWidgetState extends State<PolisExpCariListWidget> {
  late PolisExpCariBloc polisExpCariBloc;
  List<PolisExpCariModel> polisExpCari = [];
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
    polisExpCariBloc = BlocProvider.of<PolisExpCariBloc>(context);
    return BlocConsumer<PolisExpCariBloc, PolisExpCariState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            if (!state.hasReachedMax) {
              //polisExpCari.addAll(state.items);
              polisExpCari = state.items;
            }

            return state.items.isNotEmpty
                ? Flexible(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        itemCount: polisExpCari.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              padding: const EdgeInsets.all(0.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                children: <Widget>[
                                  PolisExpCariTileWidget(
                                    severity: widget.severity,
                                    cobNama: polisExpCari[index].cobNama,
                                    cstPremi: polisExpCari[index].cstPremi,
                                    curr: polisExpCari[index].curr,
                                    insuredNama:
                                        polisExpCari[index].insuredNama,
                                    periodeAkhir:
                                        polisExpCari[index].periodeAkhir,
                                    periodeAwal:
                                        polisExpCari[index].periodeAwal,
                                    polis1Id: polisExpCari[index].polis1Id,
                                    sppaNo: polisExpCari[index].sppaNo,
                                    tsi: polisExpCari[index].tsi,
                                    newSppaNo: polisExpCari[index].newSppaNo,
                                    newSppaStatus: polisExpCari[index].newSppaStatus,
                                  )
                                ],
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
      polisExpCariBloc.add(FetchPolisExpCariEvent(
          searchText: widget.searchText,          
          expgroupId: widget.expgroupId,
          personalId: widget.personalId));
    }
  }
}

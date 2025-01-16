import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstrekan/rekancari_bloc.dart';
import 'package:esalesapp/blocs/mstrekan/rekancrud_bloc.dart';
import 'package:esalesapp/pages/mstrekan/rekancari_tile_widget.dart';

class RekanCariListWidget extends StatefulWidget {
  final String rekanTypeId;
  final String searchText;
  const RekanCariListWidget({super.key, required this.rekanTypeId, required this.searchText});

  @override
  RekanCariListWidgetState createState() => RekanCariListWidgetState();
}

class RekanCariListWidgetState extends State<RekanCariListWidget> {
  late RekanCariBloc rekanCariBloc;
  late RekanCrudBloc rekanCrudBloc;
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
    rekanCariBloc = BlocProvider.of<RekanCariBloc>(context);
    rekanCrudBloc = BlocProvider.of<RekanCrudBloc>(context);
    return BlocConsumer<RekanCariBloc, RekanCariState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
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
                              child: Column(
                                children: <Widget>[
                                  Slidable(
                                      endActionPane: ActionPane(
                                          motion: const BehindMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                rekanCariBloc.add(
                                                    UbahRekanCariEvent(
                                                        recordId: state
                                                            .items[index]
                                                            .mrekanId));
                                              },
                                              backgroundColor: Colors.green,
                                              icon: Icons.edit,
                                              label: "Edit",
                                            ),
                                            SlidableAction(
                                              onPressed: (context) {
                                                showDialogHapus(state
                                                    .items[index].mrekanId);
                                              },
                                              backgroundColor: Colors.red,
                                              icon: Icons.delete,
                                              label: "Delete",
                                            ),
                                          ]),
                                      child: RekanCariTileWidget(
                                        alamat1: state.items[index].alamat1,
                                        alamat2: state.items[index].alamat2,
                                        mrekanId: state.items[index].mrekanId,
                                        mtiperekanId:
                                            state.items[index].mtiperekanId,
                                        mtitleId: state.items[index].mtitleId,
                                        rekanNama: state.items[index].rekanNama,
                                        telp1: state.items[index].telp1,
                                        telp2: state.items[index].telp2,
                                        titleDesc:
                                            state.items[index].titleDesc ?? '',
                                        catName:
                                            state.items[index].catName ?? '',
                                        marketingNama:
                                            state.items[index].marketingNama,
                                        referralName: state.items[index].referralName
                                      )),
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
      rekanCariBloc.add(FetchRekanCariEvent(rekanTypeId: widget.rekanTypeId,
          searchText: widget.searchText, hal: rekanCariBloc.state.hal,
          filterBy: rekanCariBloc.state.filterBy));
    }
  }

  onHapusFunction(String recordId) {
    rekanCrudBloc.add(RekanCrudHapusEvent(recordId: recordId));
  }

  void showDialogHapus(String recordId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowDialogHapusWidget(
              onHapusFunction: onHapusFunction, recordId: recordId);
        }).then((value) {
      rekanCariBloc.add(CloseDialogRekanCariEvent());
    });
  }
}

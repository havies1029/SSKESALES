import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/timeline/expiredbysales_bloc.dart';
import 'package:esalesapp/pages/timeline/expiredbysales_tile_widget.dart';
import 'package:esalesapp/models/timeline/expiredbysales_model.dart';

class ExpiredBySalesListWidget extends StatefulWidget {
  final int severity;
  final String expgroupId;
  final String groupNama;
  const ExpiredBySalesListWidget({super.key, 
    required this.expgroupId,
    required this.severity,
    required this.groupNama});

  @override
  ExpiredBySalesListWidgetState createState() =>
      ExpiredBySalesListWidgetState();
}

class ExpiredBySalesListWidgetState extends State<ExpiredBySalesListWidget> {
  late ExpiredBySalesBloc expiredBySalesBloc;
  List<ExpiredBySalesModel> expiredBySales = [];
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
    expiredBySalesBloc = BlocProvider.of<ExpiredBySalesBloc>(context);
    return BlocConsumer<ExpiredBySalesBloc, ExpiredBySalesState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            if (!state.hasReachedMax) {
              expiredBySales.addAll(state.items);
            }

            return state.items.isNotEmpty
                ? Flexible(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        itemCount: expiredBySales.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              padding: const EdgeInsets.all(0.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                children: <Widget>[
                                  ExpiredBySalesTileWidget(
                                    expgroupId: widget.expgroupId,  
                                    groupName: widget.groupNama,                                  
                                    severity: widget.severity,
                                    jml: expiredBySales[index].jml,
                                    salesId: expiredBySales[index].salesId,
                                    salesNama: expiredBySales[index].salesNama,
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
      expiredBySalesBloc
          .add(FetchExpiredBySalesEvent(expgroupId: widget.expgroupId));
    }
  }
}

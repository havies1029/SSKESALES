import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/jobreal/jobreal3grid_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';

class JobReal3GridListWidget extends StatefulWidget {
  const JobReal3GridListWidget({super.key});

  @override
  JobReal3GridListWidgetState createState() => JobReal3GridListWidgetState();
}

class JobReal3GridListWidgetState extends State<JobReal3GridListWidget> {
  late JobReal3GridBloc jobReal3GridBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    jobReal3GridBloc = BlocProvider.of<JobReal3GridBloc>(context);
    return BlocConsumer<JobReal3GridBloc, JobReal3GridState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            return state.items.isNotEmpty
                ? ListView.builder(
                    //shrinkWrap: true,
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: state.items.length,
                    itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          padding: const EdgeInsets.all(0.2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                            children: <Widget>[
                              JobReal3GridTileWidget(
                                  cobNama: state.items[index].cobNama)
                            ],
                          ),
                        ))
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
          //debugPrint("JobReal3GridListWidget -> buildWhen");
          return (current.status == ListStatus.success);
        },
        listener: (context, state) {});
  }
}

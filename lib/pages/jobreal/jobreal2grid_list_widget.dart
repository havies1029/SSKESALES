
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal2grid_tile_widget.dart';

class JobReal2GridListWidget extends StatefulWidget {
  const JobReal2GridListWidget({super.key});

  @override
  JobReal2GridListWidgetState createState() => JobReal2GridListWidgetState();
}

class JobReal2GridListWidgetState extends State<JobReal2GridListWidget> {
  late JobReal2GridBloc jobReal2GridBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    jobReal2GridBloc = BlocProvider.of<JobReal2GridBloc>(context);
    return BlocConsumer<JobReal2GridBloc, JobReal2GridState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {

            //debugPrint("JobReal2GridListWidgetState -> build");            
            //debugPrint("state.items : ${jsonEncode(state.items)}");
            

            return state.items.isNotEmpty
                ? ListView.builder(
                    //shrinkWrap: true,
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: state.items.length,
                    itemBuilder: (_, index) {
                      
                      return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 3),
                          padding: const EdgeInsets.all(0.1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                            children: <Widget>[
                              JobReal2GridTileWidget(
                                polis1Id: state.items[index].polis1Id,
                                polisNo: state.items[index].polisNo,
                                sppaNo: state.items[index].sppaNo,
                                periodeAwal: state.items[index].periodeAwal,
                                periodeAkhir: state.items[index].periodeAkhir,
                                curr: state.items[index].curr,
                                cstPremi: state.items[index].cstPremi,
                                tsi: state.items[index].tsi,
                                cob: state.items[index].cob,
                                insuredNama: state.items[index].insuredNama,
                                jobreal2Id: state.items[index].jobreal2Id,
                              )
                            ],
                          ),
                        );
                    })
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
}

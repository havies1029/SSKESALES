import 'package:esalesapp/blocs/soaclient/aginglist_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/soaclient/aginglist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines_plus/timelines_plus.dart';

class AgingSOATimelinePage extends StatefulWidget {
	const AgingSOATimelinePage({super.key});

	@override
	AgingSOATimelinePageState createState() => AgingSOATimelinePageState();
}

class AgingSOATimelinePageState extends State<AgingSOATimelinePage> {
	late AginglistBloc aginglistBloc;
  
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		aginglistBloc = BlocProvider.of<AginglistBloc>(context);
		return BlocConsumer<AginglistBloc, AginglistState>(
			builder: (context, state) {
		  
        if (state.status == ListStatus.success) {

          return state.items.isNotEmpty
            ? FixedTimeline.tileBuilder(
              //theme: TimelineThemeData(nodePosition: 0),
		          builder: TimelineTileBuilder.connected(
		            //contentsAlign: ContentsAlign.basic,
                connectionDirection: ConnectionDirection.before,
                connectorBuilder: (_, __, ___) =>
                        const SolidLineConnector(),
                    indicatorBuilder: (_, __) => const DotIndicator(
                      color: Colors.amber,
                    ),
                    itemCount: state.items.length,
                oppositeContentsBuilder:(context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.items[index].agingDesc,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                ),
		            contentsBuilder: (context, index) => Padding(
		              padding: const EdgeInsets.all(8.0),
		              child: AginglistTileWidget(
                    severity: state.items[index].severity,
                    agingDesc: state.items[index].agingDesc,
                    msoaagingId: state.items[index].msoaagingId,
                    range1: state.items[index].range1,
                    range2: state.items[index].range2,
                    dnCount: state.items[index].dnCount,
                    osAmount: state.items[index].osAmount,
                  ),
		            ),
		            //itemCount: state.items.length,
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
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}

  void refreshData() {
		aginglistBloc.add(
			RefreshAginglistEvent());
	}
	
}

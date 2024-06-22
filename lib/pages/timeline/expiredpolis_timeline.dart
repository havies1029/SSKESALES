import 'package:esalesapp/pages/timeline/expiredgroupcari_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/timeline/expiredgroupcari_bloc.dart';
import 'package:timelines/timelines.dart';

class ExpiredPolisTimelinePage extends StatefulWidget {
	const ExpiredPolisTimelinePage({super.key});

	@override
	ExpiredPolisTimelinePageState createState() => ExpiredPolisTimelinePageState();
}

class ExpiredPolisTimelinePageState extends State<ExpiredPolisTimelinePage> {
	late ExpiredGroupCariBloc expiredGroupCariBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		expiredGroupCariBloc = BlocProvider.of<ExpiredGroupCariBloc>(context);
		return BlocConsumer<ExpiredGroupCariBloc, ExpiredGroupCariState>(
		  builder: (context, state) {
		    return state.items.isNotEmpty ? Timeline.tileBuilder(
		          builder: TimelineTileBuilder.fromStyle(
		            contentsAlign: ContentsAlign.alternating,
		            contentsBuilder: (context, index) => Padding(
		              padding: const EdgeInsets.all(12.0),
		              child: ExpiredGroupCariTileWidget(
                    expgroupId: state.items[index].expgroupId,
                    groupNama: state.items[index].groupNama,
                    jml: state.items[index].jml,
                    noUrut: state.items[index].noUrut,),
		            ),
		            itemCount: state.items.length,
		          ),
		        ): 
        const Center(
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
		  }, listener: (BuildContext context, ExpiredGroupCariState state) {  },
		);
	}
	void refreshData() {
		expiredGroupCariBloc.add(
			RefreshExpiredGroupCariEvent());
	}

	
}

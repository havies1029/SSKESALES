import 'package:esalesapp/blocs/jobreal/realgroupcari_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/jobreal/realgroupcari_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/models/mstjob/jobsalescari_model.dart';
import 'package:grouped_list/grouped_list.dart';

class RealGroupCariListWidget extends StatefulWidget {
	final String searchText;
	const RealGroupCariListWidget({super.key, required this.searchText});

	@override
	RealGroupCariListWidgetState createState() => RealGroupCariListWidgetState();
}

class RealGroupCariListWidgetState extends State<RealGroupCariListWidget> {
	late RealGroupCariBloc jobSalesCariBloc;
	List<JobSalesCariModel> jobSalesCari = [];
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
		jobSalesCariBloc = BlocProvider.of<RealGroupCariBloc>(context);
		return BlocConsumer<RealGroupCariBloc, RealGroupCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				jobSalesCari.addAll(state.items);
			}
    var elements = state.items.map((e) => e.toJson()).toList();
		return state.items.isNotEmpty
			? Flexible(
				child: GroupedListView<dynamic, String>(                    
          controller: _scrollController,          
          elements: elements,
          groupBy: (elements) => elements['orgName'],
          groupComparator: (value1, value2) {
            return value1.compareTo(value2);
          },
          itemComparator: (item1, item2) =>
              item1['personName'].compareTo(item2['personName']),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: true,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius:
                        BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          indexedItemBuilder: (c, element, index) => Container(
						margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
						padding: const EdgeInsets.all(0.2),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(15.0)),
						child: Column(
							children: <Widget>[
								RealGroupCariTileWidget(
									orgName: state.items[index].orgName,
									personId: state.items[index].personId,
									personName: state.items[index].personName,
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
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			jobSalesCariBloc.add(FetchRealGroupCariEvent(
				searchText: widget.searchText, hal: jobSalesCariBloc.state.hal));
		}
	}

}

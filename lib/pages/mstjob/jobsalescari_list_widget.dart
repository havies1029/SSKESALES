import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/mstjob/jobsalescari_bloc.dart';
import 'package:esalesapp/pages/mstjob/jobsalescari_tile_widget.dart';
import 'package:esalesapp/models/mstjob/jobsalescari_model.dart';
import 'package:grouped_list/grouped_list.dart';

class JobSalesCariListWidget extends StatefulWidget {
	final String searchText;
	const JobSalesCariListWidget({super.key, required this.searchText});

	@override
	JobSalesCariListWidgetState createState() => JobSalesCariListWidgetState();
}

class JobSalesCariListWidgetState extends State<JobSalesCariListWidget> {
	late JobSalesCariBloc jobSalesCariBloc;
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
		jobSalesCariBloc = BlocProvider.of<JobSalesCariBloc>(context);
		return BlocConsumer<JobSalesCariBloc, JobSalesCariState>(
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
								JobSalesCariTileWidget(
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
			jobSalesCariBloc.add(FetchJobSalesCariEvent(
				searchText: widget.searchText, hal: jobSalesCariBloc.state.hal));
		}
	}

}

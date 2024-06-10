import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstjobcat/jobcatcari_bloc.dart';
import 'package:esalesapp/blocs/mstjobcat/jobcatcrud_bloc.dart';
import 'package:esalesapp/pages/mstjobcat/jobcatcari_tile_widget.dart';
import 'package:grouped_list/grouped_list.dart';

class JobCatCariListWidget extends StatefulWidget {
	final String searchText;
	const JobCatCariListWidget({super.key, required this.searchText});

	@override
	JobCatCariListWidgetState createState() => JobCatCariListWidgetState();
}

class JobCatCariListWidgetState extends State<JobCatCariListWidget> {
	late JobCatCariBloc jobCatCariBloc;
	late JobCatCrudBloc jobCatCrudBloc;
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
		jobCatCariBloc = BlocProvider.of<JobCatCariBloc>(context);
		jobCatCrudBloc = BlocProvider.of<JobCatCrudBloc>(context);
		return BlocConsumer<JobCatCariBloc, JobCatCariState>(
			builder: (context, state) {
			if (state.status == ListStatus.success) {        
        var elements = state.items.map((e) => e.toJson()).toList();
			return state.items.isNotEmpty
				? Flexible(
					child: GroupedListView<dynamic, String>(                    
              controller: _scrollController,          
              elements: elements,
              groupBy: (elements) => elements['custCatName'],
              groupComparator: (value1, value2) {
                return value1.compareTo(value2);
              },
              itemComparator: (item1, item2) =>
                  item1['mjobcatId'].compareTo(item2['mjobcatId']),
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
									Slidable(
										endActionPane: ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															jobCatCariBloc.add(
																UbahJobCatCariEvent(
																	recordId: state
																		.items[index]
																		.mjobcatId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mjobcatId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: JobCatCariTileWidget(
												catName: state.items[index].catName,
												mjobcatId: state.items[index].mjobcatId,
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
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			jobCatCariBloc.add(FetchJobCatCariEvent(
				searchText: widget.searchText, hal: jobCatCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		jobCatCrudBloc.add(JobCatCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			jobCatCariBloc.add(CloseDialogJobCatCariEvent());
		});
	}

}

import 'package:esalesapp/pages/projecttree/projecttree_view_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/projecttree/prjtreelist_bloc.dart';
import 'package:esalesapp/blocs/projecttree/prjtreecrud_bloc.dart';
import 'package:esalesapp/pages/projecttree/prjtreelist_tile_widget.dart';

class PrjtreeListListWidget extends StatefulWidget {
	final String searchText;
	const PrjtreeListListWidget({super.key, required this.searchText});

	@override
	PrjtreeListListWidgetState createState() => PrjtreeListListWidgetState();
}

class PrjtreeListListWidgetState extends State<PrjtreeListListWidget> {
	late PrjtreeListBloc prjtreeListBloc;
	late PrjtreeCrudBloc prjtreeCrudBloc;
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
		prjtreeListBloc = BlocProvider.of<PrjtreeListBloc>(context);
		prjtreeCrudBloc = BlocProvider.of<PrjtreeCrudBloc>(context);
		return BlocConsumer<PrjtreeListBloc, PrjtreeListState>(
			builder: (context, state) {
			if (state.status == ListStatus.success) {
			return state.items.isNotEmpty
				? Flexible(
					child: ListView.builder(
						padding: EdgeInsets.zero,
						controller: _scrollController,
						itemCount: state.items.length,
						itemBuilder: (_, index) => Container(
							margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
							padding: const EdgeInsets.all(0.2),
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(15.0)),
							child: Column(
								children: <Widget>[
									Slidable(
										endActionPane: (state.items[index].startedDate != null) ? 
                      ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {                                
                                  return TreeViewPage();
                                }),
                              );                    
														},
														backgroundColor: Colors.orangeAccent,
														icon: Icons.edit,
														label: "View Project",
													),													
												]
                      ) 
                      : 
                      ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															prjtreeListBloc.add(
																UbahPrjtreeListEvent(
																	recordId: state
																		.items[index]
																		.prjtree1Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].prjtree1Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: PrjtreeListTileWidget(
												prjtree1Id: state.items[index].prjtree1Id,
												projectNama: state.items[index].projectNama,
                        startedDate: state.items[index].startedDate,
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
			prjtreeListBloc.add(FetchPrjtreeListEvent());
		}
	}

	onHapusFunction(String recordId) {
		prjtreeCrudBloc.add(PrjtreeCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			prjtreeListBloc.add(CloseDialogPrjtreeListEvent());
		});
	}

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/projecttree/treenodelist_bloc.dart';
import 'package:esalesapp/blocs/projecttree/treenodecrud_bloc.dart';
import 'package:esalesapp/pages/projecttree/treenodelist_tile_widget.dart';

class TreenodeListListWidget extends StatefulWidget {
	const TreenodeListListWidget({super.key});

	@override
	TreenodeListListWidgetState createState() => TreenodeListListWidgetState();
}

class TreenodeListListWidgetState extends State<TreenodeListListWidget> {
	late TreenodeListBloc treenodeListBloc;
	late TreenodeCrudBloc treenodeCrudBloc;
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
		treenodeListBloc = BlocProvider.of<TreenodeListBloc>(context);
		treenodeCrudBloc = BlocProvider.of<TreenodeCrudBloc>(context);
		return BlocConsumer<TreenodeListBloc, TreenodeListState>(
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
										endActionPane: ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															treenodeListBloc.add(
																UbahTreenodeListEvent(
																	recordId: state
																		.items[index]
																		.prjtree2Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].prjtree2Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: TreenodeListTileWidget(
												prjnodetypeId: state.items[index].prjnodetypeId,
												prjtree1Id: state.items[index].prjtree1Id,
												prjtree2Id: state.items[index].prjtree2Id,
												prjtree2ParentId: state.items[index].prjtree2ParentId,
												remarks1: state.items[index].remarks1,
												remarks2: state.items[index].remarks2,
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
			treenodeListBloc.add(FetchTreenodeListEvent());
		}
	}

	onHapusFunction(String recordId) {
		treenodeCrudBloc.add(TreenodeCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			treenodeListBloc.add(CloseDialogTreenodeListEvent());
		});
	}

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstcob/cobcari_bloc.dart';
import 'package:esalesapp/blocs/mstcob/cobcrud_bloc.dart';
import 'package:esalesapp/pages/mstcob/cobcari_tile_widget.dart';

class CobCariListWidget extends StatefulWidget {
	final String searchText;
	const CobCariListWidget({super.key, required this.searchText});

	@override
	CobCariListWidgetState createState() => CobCariListWidgetState();
}

class CobCariListWidgetState extends State<CobCariListWidget> {
	late CobCariBloc cobCariBloc;
	late CobCrudBloc cobCrudBloc;
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
		cobCariBloc = BlocProvider.of<CobCariBloc>(context);
		cobCrudBloc = BlocProvider.of<CobCrudBloc>(context);
		return BlocConsumer<CobCariBloc, CobCariState>(
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
															cobCariBloc.add(
																UbahCobCariEvent(
																	recordId: state
																		.items[index]
																		.mcobId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mcobId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: CobCariTileWidget(
												cobNama: state.items[index].cobNama,
												mcobId: state.items[index].mcobId,
												shortName: state.items[index].shortName,
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
			cobCariBloc.add(FetchCobCariEvent(
				searchText: widget.searchText, hal: cobCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		cobCrudBloc.add(CobCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			cobCariBloc.add(CloseDialogCobCariEvent());
		});
	}

}

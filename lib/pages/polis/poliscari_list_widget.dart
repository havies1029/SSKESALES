import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/polis/poliscari_bloc.dart';
import 'package:esalesapp/blocs/polis/poliscrud_bloc.dart';
import 'package:esalesapp/pages/polis/poliscari_tile_widget.dart';

class PolisCariListWidget extends StatefulWidget {
	final String searchText;
	const PolisCariListWidget({super.key, required this.searchText});

	@override
	PolisCariListWidgetState createState() => PolisCariListWidgetState();
}

class PolisCariListWidgetState extends State<PolisCariListWidget> {
	late PolisCariBloc polisCariBloc;
	late PolisCrudBloc polisCrudBloc;
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
		polisCariBloc = BlocProvider.of<PolisCariBloc>(context);
		polisCrudBloc = BlocProvider.of<PolisCrudBloc>(context);
		return BlocConsumer<PolisCariBloc, PolisCariState>(
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
															polisCariBloc.add(
																UbahPolisCariEvent(
																	recordId: state
																		.items[index]
																		.polis1Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].polis1Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: PolisCariTileWidget(
                        curr: state.items[index].curr,
                        rekanNama: state.items[index].rekanNama,
												cobNama: state.items[index].cobNama??'',
												cstPremi: state.items[index].cstPremi,
												insuredNama: state.items[index].insuredNama,
												periodeAkhir: state.items[index].periodeAkhir,
												periodeAwal: state.items[index].periodeAwal,
												sppaNo: state.items[index].sppaNo,
												polisNo: state.items[index].polisNo,
												polis1Id: state.items[index].polis1Id,
												tsi: state.items[index].tsi,
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
			polisCariBloc.add(FetchPolisCariEvent(
				searchText: widget.searchText, hal: polisCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		polisCrudBloc.add(PolisCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			polisCariBloc.add(CloseDialogPolisCariEvent());
		});
	}

}

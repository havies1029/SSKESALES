import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mststaff/staffcari_bloc.dart';
import 'package:esalesapp/blocs/mststaff/staffcrud_bloc.dart';
import 'package:esalesapp/pages/mststaff/staffcari_tile_widget.dart';

class StaffCariListWidget extends StatefulWidget {
	final String searchText;
	const StaffCariListWidget({super.key, required this.searchText});

	@override
	StaffCariListWidgetState createState() => StaffCariListWidgetState();
}

class StaffCariListWidgetState extends State<StaffCariListWidget> {
	late StaffCariBloc staffCariBloc;
	late StaffCrudBloc staffCrudBloc;
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
		staffCariBloc = BlocProvider.of<StaffCariBloc>(context);
		staffCrudBloc = BlocProvider.of<StaffCrudBloc>(context);
		return BlocConsumer<StaffCariBloc, StaffCariState>(
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
															staffCariBloc.add(
																UbahStaffCariEvent(
																	recordId: state
																		.items[index]
																		.mstaffId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mstaffId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: StaffCariTileWidget(
												gaji: state.items[index].gaji,
												uangMakan: state.items[index].uangMakan,
												alamat: state.items[index].alamat,
												email: state.items[index].email,
												hp: state.items[index].hp,
												jabatanDesc: state.items[index].jabatanDesc??'',
												ktp: state.items[index].ktp,
												mjabatanId: state.items[index].mjabatanId,
												mstaffId: state.items[index].mstaffId,
												staffNama: state.items[index].staffNama,
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
			staffCariBloc.add(FetchStaffCariEvent(
				searchText: widget.searchText, hal: staffCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		staffCrudBloc.add(StaffCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			staffCariBloc.add(CloseDialogStaffCariEvent());
		});
	}

}

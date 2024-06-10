import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/msttitle/titlecari_bloc.dart';
import 'package:esalesapp/blocs/msttitle/titlecrud_bloc.dart';
import 'package:esalesapp/pages/msttitle/titlecari_tile_widget.dart';

class TitleCariListWidget extends StatefulWidget {
	final String searchText;
	const TitleCariListWidget({super.key, required this.searchText});

	@override
	TitleCariListWidgetState createState() => TitleCariListWidgetState();
}

class TitleCariListWidgetState extends State<TitleCariListWidget> {
	late TitleCariBloc titleCariBloc;
	late TitleCrudBloc titleCrudBloc;
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
		titleCariBloc = BlocProvider.of<TitleCariBloc>(context);
		titleCrudBloc = BlocProvider.of<TitleCrudBloc>(context);
		return BlocConsumer<TitleCariBloc, TitleCariState>(
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
															titleCariBloc.add(
																UbahTitleCariEvent(
																	recordId: state
																		.items[index]
																		.mtitleId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mtitleId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: TitleCariTileWidget(
												mtitleId: state.items[index].mtitleId,
												titleDesc: state.items[index].titleDesc,
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
			titleCariBloc.add(FetchTitleCariEvent(
				searchText: widget.searchText, hal: titleCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		titleCrudBloc.add(TitleCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			titleCariBloc.add(CloseDialogTitleCariEvent());
		});
	}

}

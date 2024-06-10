import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstmedia/mediacari_bloc.dart';
import 'package:esalesapp/blocs/mstmedia/mediacrud_bloc.dart';
import 'package:esalesapp/pages/mstmedia/mediacari_tile_widget.dart';

class MediaCariListWidget extends StatefulWidget {
	final String searchText;
	const MediaCariListWidget({super.key, required this.searchText});

	@override
	MediaCariListWidgetState createState() => MediaCariListWidgetState();
}

class MediaCariListWidgetState extends State<MediaCariListWidget> {
	late MediaCariBloc mediaCariBloc;
	late MediaCrudBloc mediaCrudBloc;
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
		mediaCariBloc = BlocProvider.of<MediaCariBloc>(context);
		mediaCrudBloc = BlocProvider.of<MediaCrudBloc>(context);
		return BlocConsumer<MediaCariBloc, MediaCariState>(
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
															mediaCariBloc.add(
																UbahMediaCariEvent(
																	recordId: state
																		.items[index]
																		.mmediaId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mmediaId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: MediaCariTileWidget(
												mediaNama: state.items[index].mediaNama,
												mmediaId: state.items[index].mmediaId,
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
			mediaCariBloc.add(FetchMediaCariEvent(
				searchText: widget.searchText, hal: mediaCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		mediaCrudBloc.add(MediaCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			mediaCariBloc.add(CloseDialogMediaCariEvent());
		});
	}

}

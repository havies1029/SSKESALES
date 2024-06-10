import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstjobgroup/jobgroupcari_bloc.dart';
import 'package:esalesapp/blocs/mstjobgroup/jobgroupcrud_bloc.dart';
import 'package:esalesapp/pages/mstjobgroup/jobgroupcari_tile_widget.dart';

class JobGroupCariListWidget extends StatefulWidget {
	final String searchText;
	const JobGroupCariListWidget({super.key, required this.searchText});

	@override
	JobGroupCariListWidgetState createState() => JobGroupCariListWidgetState();
}

class JobGroupCariListWidgetState extends State<JobGroupCariListWidget> {
	late JobGroupCariBloc jobGroupCariBloc;
	late JobGroupCrudBloc jobGroupCrudBloc;
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
		jobGroupCariBloc = BlocProvider.of<JobGroupCariBloc>(context);
		jobGroupCrudBloc = BlocProvider.of<JobGroupCrudBloc>(context);
		return BlocConsumer<JobGroupCariBloc, JobGroupCariState>(
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
															jobGroupCariBloc.add(
																UbahJobGroupCariEvent(
																	recordId: state
																		.items[index]
																		.mjobgroupId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mjobgroupId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: JobGroupCariTileWidget(
												groupName: state.items[index].groupName,
												mjobgroupId: state.items[index].mjobgroupId,
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
			jobGroupCariBloc.add(FetchJobGroupCariEvent(
				searchText: widget.searchText, hal: jobGroupCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		jobGroupCrudBloc.add(JobGroupCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			jobGroupCariBloc.add(CloseDialogJobGroupCariEvent());
		});
	}

}

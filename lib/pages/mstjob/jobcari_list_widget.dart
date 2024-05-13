import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstjob/jobcari_bloc.dart';
import 'package:esalesapp/blocs/mstjob/jobcrud_bloc.dart';
import 'package:esalesapp/pages/mstjob/jobcari_tile_widget.dart';

class JobCariListWidget extends StatefulWidget {
	final String searchText;
	const JobCariListWidget({super.key, required this.searchText});

	@override
	JobCariListWidgetState createState() => JobCariListWidgetState();
}

class JobCariListWidgetState extends State<JobCariListWidget> {
	late JobCariBloc jobCariBloc;
	late JobCrudBloc jobCrudBloc;
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
		jobCariBloc = BlocProvider.of<JobCariBloc>(context);
		jobCrudBloc = BlocProvider.of<JobCrudBloc>(context);
		return BlocConsumer<JobCariBloc, JobCariState>(
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
															jobCariBloc.add(
																UbahJobCariEvent(
																	recordId: state
																		.items[index]
																		.mjobId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mjobId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: JobCariTileWidget(
												catName: state.items[index].catName??'',
												jobNama: state.items[index].jobNama,
												mjobId: state.items[index].mjobId,
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
			jobCariBloc.add(FetchJobCariEvent(
				searchText: widget.searchText, hal: jobCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		jobCrudBloc.add(JobCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			jobCariBloc.add(CloseDialogJobCariEvent());
		});
	}

}

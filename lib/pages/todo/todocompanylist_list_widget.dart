import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/todo/todocompanylist_bloc.dart';
import 'package:esalesapp/blocs/todo/todocompanycrud_bloc.dart';
import 'package:esalesapp/pages/todo/todocompanylist_tile_widget.dart';

class TodoCompanyListListWidget extends StatefulWidget {
	const TodoCompanyListListWidget({super.key});

	@override
	TodoCompanyListListWidgetState createState() => TodoCompanyListListWidgetState();
}

class TodoCompanyListListWidgetState extends State<TodoCompanyListListWidget> {
	late TodoCompanyListBloc todoCompanyListBloc;
	late TodoCompanyCrudBloc todoCompanyCrudBloc;
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
		todoCompanyListBloc = BlocProvider.of<TodoCompanyListBloc>(context);
		todoCompanyCrudBloc = BlocProvider.of<TodoCompanyCrudBloc>(context);
		return BlocConsumer<TodoCompanyListBloc, TodoCompanyListState>(
			builder: (context, state) {
			if (state.status == ListStatus.success) {
			return state.items.isNotEmpty
				? ListView.builder(
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
														todoCompanyListBloc.add(
															UbahTodoCompanyListEvent(
																recordId: state
																	.items[index]
																	.timeline2Id));
													},
													backgroundColor: Colors.green,
													icon: Icons.edit,
													label: "Edit",
												),
												SlidableAction(
													onPressed: (context) {
														showDialogHapus(
															state.items[index].timeline2Id);
													},
													backgroundColor: Colors.red,
													icon: Icons.delete,
													label: "Delete",
												),
											]),
										child: TodoCompanyListTileWidget(
											customerName: state.items[index].customerName,
										)),
						],
					),
				))
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
			todoCompanyListBloc.add(FetchTodoCompanyListEvent());
		}
	}

	onHapusFunction(String recordId) {
		todoCompanyCrudBloc.add(TodoCompanyCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			todoCompanyListBloc.add(CloseDialogTodoCompanyListEvent());
		});
	}

}

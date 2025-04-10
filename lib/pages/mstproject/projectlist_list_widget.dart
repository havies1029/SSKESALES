import 'package:esalesapp/pages/projectplan/planlist_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstproject/projectlist_bloc.dart';
import 'package:esalesapp/blocs/mstproject/projectcrud_bloc.dart';
import 'package:esalesapp/pages/mstproject/projectlist_tile_widget.dart';

class ProjectListListWidget extends StatefulWidget {
	final String searchText;
	const ProjectListListWidget({super.key, required this.searchText});

	@override
	ProjectListListWidgetState createState() => ProjectListListWidgetState();
}

class ProjectListListWidgetState extends State<ProjectListListWidget> {
	late ProjectListBloc projectListBloc;
	late ProjectCrudBloc projectCrudBloc;
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
		projectListBloc = BlocProvider.of<ProjectListBloc>(context);
		projectCrudBloc = BlocProvider.of<ProjectCrudBloc>(context);
		return BlocConsumer<ProjectListBloc, ProjectListState>(
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
                    startActionPane: ActionPane(
                      motion: BehindMotion(), 
                      children: [
                        state.items[index].startedDate == null ? 
                        Container():
                        SlidableAction(
                          onPressed: (context) {    
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {                                
                                return PlanListMainPage( clientName: state.items[index].rekanNama,
                                  projectName: state.items[index].projectNama, 
                                  projectId: state.items[index].mprojectId);
                              }),
                            );                        
                          },
                          backgroundColor: Colors.orangeAccent,
                          icon: Icons.copy,
                          label: "View Progress",
                        ),
                      ]),
										endActionPane: (state.items[index].startedDate != null) ? null : ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															projectListBloc.add(
																UbahProjectListEvent(
																	recordId: state
																		.items[index]
																		.mprojectId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mprojectId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: ProjectListTileWidget(
												dateline: state.items[index].dateline,
												mprojectId: state.items[index].mprojectId,
												projectNama: state.items[index].projectNama,
                        clientName: state.items[index].rekanNama,
                        cobNama: state.items[index].cobNama,
                        catName: state.items[index].catName,
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
			projectListBloc.add(FetchProjectListEvent());
		}
	}

	onHapusFunction(String recordId) {
		projectCrudBloc.add(ProjectCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			projectListBloc.add(CloseDialogProjectListEvent());
		});
	}

}

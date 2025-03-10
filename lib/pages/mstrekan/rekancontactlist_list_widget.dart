import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:esalesapp/widgets/showdialoghapus_widget.dart';
import 'package:esalesapp/blocs/mstrekan/rekancontactlist_bloc.dart';
import 'package:esalesapp/blocs/mstrekan/rekancontactcrud_bloc.dart';
import 'package:esalesapp/pages/mstrekan/rekancontactlist_tile_widget.dart';

class RekanContactListListWidget extends StatefulWidget {
	const RekanContactListListWidget({super.key});

	@override
	RekanContactListListWidgetState createState() => RekanContactListListWidgetState();
}

class RekanContactListListWidgetState extends State<RekanContactListListWidget> {
	late RekanContactListBloc rekanContactListBloc;
	late RekanContactCrudBloc rekanContactCrudBloc;
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
		rekanContactListBloc = BlocProvider.of<RekanContactListBloc>(context);
		rekanContactCrudBloc = BlocProvider.of<RekanContactCrudBloc>(context);
		return BlocConsumer<RekanContactListBloc, RekanContactListState>(
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
															rekanContactListBloc.add(
																UbahRekanContactListEvent(
																	recordId: state
																		.items[index]
																		.mcontactId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mcontactId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
											  children: [                          
                          Expanded(flex: 1, child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text((index + 1).toString()),
                          )),
											    Expanded(
                            flex: 15,
                            child: RekanContactListTileWidget(
                              contactNama: state.items[index].contactNama,
                              email: state.items[index].email,
                              noHp: state.items[index].noHp,
                              titleDesc: state.items[index].titleDesc,
                                                    jabatanDesc: state.items[index].jabatanNama,
                            ),
                          ),
											  ],
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
			rekanContactListBloc.add(FetchRekanContactListEvent());
		}
	}

	onHapusFunction(String recordId) {
		rekanContactCrudBloc.add(RekanContactCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			rekanContactListBloc.add(CloseDialogRekanContactListEvent());
		});
	}

}

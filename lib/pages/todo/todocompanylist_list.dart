import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/todo/todocompanylist_bloc.dart';
import 'package:esalesapp/blocs/todo/todocompanycrud_bloc.dart';
import 'package:esalesapp/pages/todo/todocompanycrud_form.dart';
import 'package:esalesapp/pages/todo/todocompanylist_list_widget.dart';

class TodoCompanyListPage extends StatefulWidget {
	final String timeline1Id;
	const TodoCompanyListPage({super.key, required this.timeline1Id});

	@override
	TodoCompanyListPageState createState() => TodoCompanyListPageState();
}

class TodoCompanyListPageState extends State<TodoCompanyListPage> {
	late TodoCompanyListBloc todoCompanyListBloc;
	late TodoCompanyCrudBloc todoCompanyCrudBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		todoCompanyListBloc = BlocProvider.of<TodoCompanyListBloc>(context);
		todoCompanyCrudBloc = BlocProvider.of<TodoCompanyCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<TodoCompanyListBloc, TodoCompanyListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<TodoCompanyCrudBloc, TodoCompanyCrudState>(
					listener: (context, state) {
						if (state.isSaved) {
							refreshData();
						}
				}, listenWhen: (previous, current) {
					return previous.isSaved != current.isSaved;
				}),
			],
			child: Scaffold(
				floatingActionButton: FloatingMenuMasterWidget(
					onTambah: onTambahData),
				body: buildList()
			));
	}

	void refreshData() {
		todoCompanyListBloc.add(
			RefreshTodoCompanyListEvent(timeline1Id: widget.timeline1Id, hal: 0));
	}

	void onTambahData() {
		todoCompanyListBloc.add(TambahTodoCompanyListEvent());
	}

	Widget buildList() {
		return TodoCompanyListListWidget();
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return TodoCompanyCrudFormPage(timeline1Id: widget.timeline1Id, viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			todoCompanyListBloc.add(CloseDialogTodoCompanyListEvent());
		});
	}

}

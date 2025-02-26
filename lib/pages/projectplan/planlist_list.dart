import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/projectplan/planlist_bloc.dart';
import 'package:esalesapp/blocs/projectplan/plancrud_bloc.dart';
import 'package:esalesapp/pages/projectplan/plancrud_form.dart';
import 'package:esalesapp/pages/projectplan/planlist_list_widget.dart';

class PlanListPage extends StatefulWidget {
  final String projectId;
	const PlanListPage({super.key, required this.projectId});

	@override
	PlanListPageState createState() => PlanListPageState();
}

class PlanListPageState extends State<PlanListPage> {
	late PlanListBloc planListBloc;
	late PlanCrudBloc planCrudBloc;
	final TextEditingController _searchController = TextEditingController();
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		planListBloc = BlocProvider.of<PlanListBloc>(context);
		planCrudBloc = BlocProvider.of<PlanCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<PlanListBloc, PlanListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<PlanCrudBloc, PlanCrudState>(
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
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: [
							ListPageFilterBarUIWidget(
								searchController: _searchController,
								searchButton: buildSearchButton()),
							buildList()
						],

					),
				),
			));
	}

	void refreshData() {
		//planListBloc.add(//RefreshPlanListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		planListBloc.add(TambahPlanListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
        /*
			planListBloc.add(RefreshPlanListEvent(
				searchText: _searchController.text, hal: 0));
        */
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[PlanListListWidget(projectId: widget.projectId)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return PlanCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			planListBloc.add(CloseDialogPlanListEvent());
		});
	}

}

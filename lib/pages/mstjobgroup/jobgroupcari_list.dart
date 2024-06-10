import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstjobgroup/jobgroupcari_bloc.dart';
import 'package:esalesapp/blocs/mstjobgroup/jobgroupcrud_bloc.dart';
import 'package:esalesapp/pages/mstjobgroup/jobgroupcrud_form.dart';
import 'package:esalesapp/pages/mstjobgroup/jobgroupcari_list_widget.dart';

class JobGroupCariPage extends StatefulWidget {
	const JobGroupCariPage({super.key});

	@override
	JobGroupCariPageState createState() => JobGroupCariPageState();
}

class JobGroupCariPageState extends State<JobGroupCariPage> {
	late JobGroupCariBloc jobGroupCariBloc;
	late JobGroupCrudBloc jobGroupCrudBloc;
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
		jobGroupCariBloc = BlocProvider.of<JobGroupCariBloc>(context);
		jobGroupCrudBloc = BlocProvider.of<JobGroupCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<JobGroupCariBloc, JobGroupCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<JobGroupCrudBloc, JobGroupCrudState>(
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
		jobGroupCariBloc.add(
			RefreshJobGroupCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		jobGroupCariBloc.add(TambahJobGroupCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			jobGroupCariBloc.add(RefreshJobGroupCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[JobGroupCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return JobGroupCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			jobGroupCariBloc.add(CloseDialogJobGroupCariEvent());
		});
	}

}

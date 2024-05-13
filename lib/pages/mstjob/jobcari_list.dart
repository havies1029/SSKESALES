import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstjob/jobcari_bloc.dart';
import 'package:esalesapp/blocs/mstjob/jobcrud_bloc.dart';
import 'package:esalesapp/pages/mstjob/jobcrud_form.dart';
import 'package:esalesapp/pages/mstjob/jobcari_list_widget.dart';

class JobCariPage extends StatefulWidget {
	const JobCariPage({super.key});

	@override
	JobCariPageState createState() => JobCariPageState();
}

class JobCariPageState extends State<JobCariPage> {
	late JobCariBloc jobCariBloc;
	late JobCrudBloc jobCrudBloc;
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
		jobCariBloc = BlocProvider.of<JobCariBloc>(context);
		jobCrudBloc = BlocProvider.of<JobCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<JobCariBloc, JobCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<JobCrudBloc, JobCrudState>(
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
		jobCariBloc.add(
			RefreshJobCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		jobCariBloc.add(TambahJobCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			jobCariBloc.add(RefreshJobCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[JobCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return JobCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			jobCariBloc.add(CloseDialogJobCariEvent());
		});
	}

}

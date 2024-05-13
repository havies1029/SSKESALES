import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstjobcat/jobcatcari_bloc.dart';
import 'package:esalesapp/blocs/mstjobcat/jobcatcrud_bloc.dart';
import 'package:esalesapp/pages/mstjobcat/jobcatcrud_form.dart';
import 'package:esalesapp/pages/mstjobcat/jobcatcari_list_widget.dart';

class JobCatCariPage extends StatefulWidget {
	const JobCatCariPage({super.key});

	@override
	JobCatCariPageState createState() => JobCatCariPageState();
}

class JobCatCariPageState extends State<JobCatCariPage> {
	late JobCatCariBloc jobCatCariBloc;
	late JobCatCrudBloc jobCatCrudBloc;
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
		jobCatCariBloc = BlocProvider.of<JobCatCariBloc>(context);
		jobCatCrudBloc = BlocProvider.of<JobCatCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<JobCatCariBloc, JobCatCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<JobCatCrudBloc, JobCatCrudState>(
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
		jobCatCariBloc.add(
			RefreshJobCatCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		jobCatCariBloc.add(TambahJobCatCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			jobCatCariBloc.add(RefreshJobCatCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[JobCatCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return JobCatCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			jobCatCariBloc.add(CloseDialogJobCatCariEvent());
		});
	}

}

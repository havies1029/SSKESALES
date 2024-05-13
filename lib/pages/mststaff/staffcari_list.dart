import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mststaff/staffcari_bloc.dart';
import 'package:esalesapp/blocs/mststaff/staffcrud_bloc.dart';
import 'package:esalesapp/pages/mststaff/staffcrud_form.dart';
import 'package:esalesapp/pages/mststaff/staffcari_list_widget.dart';

class StaffCariPage extends StatefulWidget {
	const StaffCariPage({super.key});

	@override
	StaffCariPageState createState() => StaffCariPageState();
}

class StaffCariPageState extends State<StaffCariPage> {
	late StaffCariBloc staffCariBloc;
	late StaffCrudBloc staffCrudBloc;
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
		staffCariBloc = BlocProvider.of<StaffCariBloc>(context);
		staffCrudBloc = BlocProvider.of<StaffCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<StaffCariBloc, StaffCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<StaffCrudBloc, StaffCrudState>(
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
		staffCariBloc.add(
			RefreshStaffCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		staffCariBloc.add(TambahStaffCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			staffCariBloc.add(RefreshStaffCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[StaffCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return StaffCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			staffCariBloc.add(CloseDialogStaffCariEvent());
		});
	}

}

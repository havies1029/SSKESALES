import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstcob/cobcari_bloc.dart';
import 'package:esalesapp/blocs/mstcob/cobcrud_bloc.dart';
import 'package:esalesapp/pages/mstcob/cobcrud_form.dart';
import 'package:esalesapp/pages/mstcob/cobcari_list_widget.dart';

class CobCariPage extends StatefulWidget {
	const CobCariPage({super.key});

	@override
	CobCariPageState createState() => CobCariPageState();
}

class CobCariPageState extends State<CobCariPage> {
	late CobCariBloc cobCariBloc;
	late CobCrudBloc cobCrudBloc;
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
		cobCariBloc = BlocProvider.of<CobCariBloc>(context);
		cobCrudBloc = BlocProvider.of<CobCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<CobCariBloc, CobCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<CobCrudBloc, CobCrudState>(
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
		cobCariBloc.add(
			RefreshCobCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		cobCariBloc.add(TambahCobCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			cobCariBloc.add(RefreshCobCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[CobCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return CobCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			cobCariBloc.add(CloseDialogCobCariEvent());
		});
	}

}

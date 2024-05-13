import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/msttitle/titlecari_bloc.dart';
import 'package:esalesapp/blocs/msttitle/titlecrud_bloc.dart';
import 'package:esalesapp/pages/msttitle/titlecrud_form.dart';
import 'package:esalesapp/pages/msttitle/titlecari_list_widget.dart';

class TitleCariPage extends StatefulWidget {
	const TitleCariPage({super.key});

	@override
	TitleCariPageState createState() => TitleCariPageState();
}

class TitleCariPageState extends State<TitleCariPage> {
	late TitleCariBloc titleCariBloc;
	late TitleCrudBloc titleCrudBloc;
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
		titleCariBloc = BlocProvider.of<TitleCariBloc>(context);
		titleCrudBloc = BlocProvider.of<TitleCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<TitleCariBloc, TitleCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<TitleCrudBloc, TitleCrudState>(
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
		titleCariBloc.add(
			RefreshTitleCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		titleCariBloc.add(TambahTitleCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			titleCariBloc.add(RefreshTitleCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[TitleCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return TitleCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			titleCariBloc.add(CloseDialogTitleCariEvent());
		});
	}

}

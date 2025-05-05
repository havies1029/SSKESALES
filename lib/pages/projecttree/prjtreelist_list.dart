import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/projecttree/prjtreelist_bloc.dart';
import 'package:esalesapp/blocs/projecttree/prjtreecrud_bloc.dart';
import 'package:esalesapp/pages/projecttree/prjtreecrud_form.dart';
import 'package:esalesapp/pages/projecttree/prjtreelist_list_widget.dart';

class PrjtreeListPage extends StatefulWidget {
	const PrjtreeListPage({super.key});

	@override
	PrjtreeListPageState createState() => PrjtreeListPageState();
}

class PrjtreeListPageState extends State<PrjtreeListPage> {
	late PrjtreeListBloc prjtreeListBloc;
	late PrjtreeCrudBloc prjtreeCrudBloc;
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
		prjtreeListBloc = BlocProvider.of<PrjtreeListBloc>(context);
		prjtreeCrudBloc = BlocProvider.of<PrjtreeCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<PrjtreeListBloc, PrjtreeListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<PrjtreeCrudBloc, PrjtreeCrudState>(
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
		prjtreeListBloc.add(
			RefreshPrjtreeListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		prjtreeListBloc.add(TambahPrjtreeListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			prjtreeListBloc.add(RefreshPrjtreeListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[PrjtreeListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return PrjtreeCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			prjtreeListBloc.add(CloseDialogPrjtreeListEvent());
		});
	}

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstcustcat/custcatcari_bloc.dart';
import 'package:esalesapp/blocs/mstcustcat/custcatcrud_bloc.dart';
import 'package:esalesapp/pages/mstcustcat/custcatcrud_form.dart';
import 'package:esalesapp/pages/mstcustcat/custcatcari_list_widget.dart';

class CustCatCariPage extends StatefulWidget {
	const CustCatCariPage({super.key});

	@override
	CustCatCariPageState createState() => CustCatCariPageState();
}

class CustCatCariPageState extends State<CustCatCariPage> {
	late CustCatCariBloc custCatCariBloc;
	late CustCatCrudBloc custCatCrudBloc;
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
		custCatCariBloc = BlocProvider.of<CustCatCariBloc>(context);
		custCatCrudBloc = BlocProvider.of<CustCatCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<CustCatCariBloc, CustCatCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<CustCatCrudBloc, CustCatCrudState>(
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
		custCatCariBloc.add(
			RefreshCustCatCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		custCatCariBloc.add(TambahCustCatCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			custCatCariBloc.add(RefreshCustCatCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[CustCatCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return CustCatCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			custCatCariBloc.add(CloseDialogCustCatCariEvent());
		});
	}

}

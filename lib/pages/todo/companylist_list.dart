import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/todo/companylist_bloc.dart';
import 'package:esalesapp/blocs/todo/companycrud_bloc.dart';
import 'package:esalesapp/pages/todo/companycrud_form.dart';
import 'package:esalesapp/pages/todo/companylist_list_widget.dart';

class CompanyListPage extends StatefulWidget {
	final String timeline1Id;
	const CompanyListPage({super.key, required this.timeline1Id});

	@override
	CompanyListPageState createState() => CompanyListPageState();
}

class CompanyListPageState extends State<CompanyListPage> {
	late CompanyListBloc companyListBloc;
	late CompanyCrudBloc companyCrudBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		companyListBloc = BlocProvider.of<CompanyListBloc>(context);
		companyCrudBloc = BlocProvider.of<CompanyCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<CompanyListBloc, CompanyListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<CompanyCrudBloc, CompanyCrudState>(
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
		companyListBloc.add(
			RefreshCompanyListEvent(timeline1Id: widget.timeline1Id, hal: 0));
	}

	void onTambahData() {
		companyListBloc.add(TambahCompanyListEvent());
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[CompanyListListWidget()],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return CompanyCrudFormPage(timeline1Id: widget.timeline1Id, viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			companyListBloc.add(CloseDialogCompanyListEvent());
		});
	}

}

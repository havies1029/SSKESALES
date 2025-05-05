import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/projecttree/treenodelist_bloc.dart';
import 'package:esalesapp/blocs/projecttree/treenodecrud_bloc.dart';
import 'package:esalesapp/pages/projecttree/treenodecrud_form.dart';
import 'package:esalesapp/pages/projecttree/treenodelist_list_widget.dart';

class TreenodeListPage extends StatefulWidget {
	final String prjtree1Id;
	const TreenodeListPage({super.key, required this.prjtree1Id});

	@override
	TreenodeListPageState createState() => TreenodeListPageState();
}

class TreenodeListPageState extends State<TreenodeListPage> {
	late TreenodeListBloc treenodeListBloc;
	late TreenodeCrudBloc treenodeCrudBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		treenodeListBloc = BlocProvider.of<TreenodeListBloc>(context);
		treenodeCrudBloc = BlocProvider.of<TreenodeCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<TreenodeListBloc, TreenodeListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<TreenodeCrudBloc, TreenodeCrudState>(
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
		treenodeListBloc.add(
			RefreshTreenodeListEvent(prjtree1Id: widget.prjtree1Id, hal: 0));
	}

	void onTambahData() {
		treenodeListBloc.add(TambahTreenodeListEvent());
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[TreenodeListListWidget()],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return TreenodeCrudFormPage(prjtree1Id: widget.prjtree1Id, viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			treenodeListBloc.add(CloseDialogTreenodeListEvent());
		});
	}

}

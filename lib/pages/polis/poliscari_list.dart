import 'package:esalesapp/pages/polis/poliscrud_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/polis/poliscari_bloc.dart';
import 'package:esalesapp/blocs/polis/poliscrud_bloc.dart';
import 'package:esalesapp/pages/polis/poliscari_list_widget.dart';

class PolisCariPage extends StatefulWidget {
	const PolisCariPage({super.key});

	@override
	PolisCariPageState createState() => PolisCariPageState();
}

class PolisCariPageState extends State<PolisCariPage> {
	late PolisCariBloc polisCariBloc;
	late PolisCrudBloc polisCrudBloc;
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
		polisCariBloc = BlocProvider.of<PolisCariBloc>(context);
		polisCrudBloc = BlocProvider.of<PolisCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<PolisCariBloc, PolisCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<PolisCrudBloc, PolisCrudState>(
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
		polisCariBloc.add(
			RefreshPolisCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		polisCariBloc.add(TambahPolisCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			polisCariBloc.add(RefreshPolisCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[PolisCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {        
          return PolisCrudMainPage(viewMode: viewMode, recordId: recordId);
        }),
      ).then((value) {
        return polisCariBloc.add(CloseDialogPolisCariEvent());
      });
	}

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/blocs/assignment/clientassigncari_bloc.dart';
import 'package:esalesapp/pages/assignment/clientassigncari_list_widget.dart';

class ClientAssignCariPage extends StatefulWidget {
	const ClientAssignCariPage({super.key});

	@override
	ClientAssignCariPageState createState() => ClientAssignCariPageState();
}

class ClientAssignCariPageState extends State<ClientAssignCariPage> {
	late ClientAssignCariBloc clientAssignCariBloc;
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
		clientAssignCariBloc = BlocProvider.of<ClientAssignCariBloc>(context);
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: [
					ListPageFilterBarUIWidget(
						searchController: _searchController,
						searchButton: buildSearchButton()),
					buildList()
				],

			),
		);
	}
	void refreshData() {
		clientAssignCariBloc.add(
			RefreshClientAssignCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			clientAssignCariBloc.add(RefreshClientAssignCariEvent(
				));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[ClientAssignCariListWidget(searchText: _searchController.text)],
		));
	}

}

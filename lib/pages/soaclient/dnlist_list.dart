import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/blocs/soaclient/dnlist_bloc.dart';
import 'package:esalesapp/pages/soaclient/dnlist_list_widget.dart';

class DnlistPage extends StatefulWidget {
  final String soaAgingId;
	const DnlistPage({super.key, required this.soaAgingId});

	@override
	DnlistPageState createState() => DnlistPageState();
}

class DnlistPageState extends State<DnlistPage> {
	late DnlistBloc dnlistBloc;
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
		dnlistBloc = BlocProvider.of<DnlistBloc>(context);
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
		dnlistBloc.add(
			RefreshDnlistEvent(soaAgingId: widget.soaAgingId, searchText: _searchController.text));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			dnlistBloc.add(RefreshDnlistEvent(soaAgingId: widget.soaAgingId, searchText: _searchController.text));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[DnlistListWidget(searchText: _searchController.text)],
		));
	}

}

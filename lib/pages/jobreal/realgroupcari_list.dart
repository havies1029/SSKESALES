import 'package:esalesapp/blocs/jobreal/realgroupcari_bloc.dart';
import 'package:esalesapp/pages/jobreal/realgroupcari_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';

class RealGroupCariPage extends StatefulWidget {
	const RealGroupCariPage({super.key});

	@override
	RealGroupCariPageState createState() => RealGroupCariPageState();
}

class RealGroupCariPageState extends State<RealGroupCariPage> {
	late RealGroupCariBloc jobSalesCariBloc;
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
		jobSalesCariBloc = BlocProvider.of<RealGroupCariBloc>(context);
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
		jobSalesCariBloc.add(
			RefreshRealGroupCariEvent(searchText: _searchController.text, hal: 0));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			jobSalesCariBloc.add(RefreshRealGroupCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[RealGroupCariListWidget(searchText: _searchController.text)],
		));
	}

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/blocs/timeline/polisexpcari_bloc.dart';
import 'package:esalesapp/pages/timeline/polisexpcari_list_widget.dart';

class PolisExpCariPage extends StatefulWidget {
  final int severity;
  final String expgroupId;
  final String personalId;
	const PolisExpCariPage({super.key,
      required this.expgroupId,
      required this.severity,
      required this.personalId,
  });

	@override
	PolisExpCariPageState createState() => PolisExpCariPageState();
}

class PolisExpCariPageState extends State<PolisExpCariPage> {
	late PolisExpCariBloc polisExpCariBloc;
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
		polisExpCariBloc = BlocProvider.of<PolisExpCariBloc>(context);
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
		polisExpCariBloc.add(
			RefreshPolisExpCariEvent(searchText: _searchController.text, hal: 0, expgroupId: widget.expgroupId, personalId: widget.personalId));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			polisExpCariBloc.add(RefreshPolisExpCariEvent(
        searchText: _searchController.text, hal: 0,
        expgroupId: widget.expgroupId, personalId: widget.personalId
				));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[PolisExpCariListWidget(
          searchText: _searchController.text,
          expgroupId: widget.expgroupId,
          personalId: widget.personalId,
          severity: widget.severity,)],
		));
	}

}

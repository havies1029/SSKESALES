import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/blocs/mstjob/jobsalescari_bloc.dart';
import 'package:esalesapp/pages/mstjob/jobsalescari_list_widget.dart';

class JobSalesCariPage extends StatefulWidget {
	const JobSalesCariPage({super.key});

	@override
	JobSalesCariPageState createState() => JobSalesCariPageState();
}

class JobSalesCariPageState extends State<JobSalesCariPage> {
	late JobSalesCariBloc jobSalesCariBloc;
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
		jobSalesCariBloc = BlocProvider.of<JobSalesCariBloc>(context);
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
			RefreshJobSalesCariEvent(searchText: _searchController.text, hal: 0));
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			jobSalesCariBloc.add(RefreshJobSalesCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[JobSalesCariListWidget(searchText: _searchController.text)],
		));
	}

}

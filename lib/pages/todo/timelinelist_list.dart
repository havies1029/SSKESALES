import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/todo/timelinelist_bloc.dart';
import 'package:esalesapp/blocs/todo/timelinecrud_bloc.dart';
import 'package:esalesapp/pages/todo/timelinecrud_main.dart';
import 'package:esalesapp/pages/todo/timelinelist_list_widget.dart';

class TimelineListPage extends StatefulWidget {
	const TimelineListPage({super.key});

	@override
	TimelineListPageState createState() => TimelineListPageState();
}

class TimelineListPageState extends State<TimelineListPage> {
	late TimelineListBloc timelineListBloc;
	late TimelineCrudBloc timelineCrudBloc;
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
		timelineListBloc = BlocProvider.of<TimelineListBloc>(context);
		timelineCrudBloc = BlocProvider.of<TimelineCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<TimelineListBloc, TimelineListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<TimelineCrudBloc, TimelineCrudState>(
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
		timelineListBloc.add(
			RefreshTimelineListEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		timelineListBloc.add(TambahTimelineListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			timelineListBloc.add(RefreshTimelineListEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[TimelineListListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) {
				return TimelineCrudMainPage(viewMode: viewMode, recordId: recordId);
			}),
		);

	}
}

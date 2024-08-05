import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal3cari_list_widget.dart';

class JobReal3CariPage extends StatefulWidget {
  final String jobReal1Id;
  const JobReal3CariPage({super.key, required this.jobReal1Id});

  @override
  JobReal3CariPageState createState() => JobReal3CariPageState();
}

class JobReal3CariPageState extends State<JobReal3CariPage> {
  late JobReal3CariBloc jobReal3CariBloc;
  late JobReal3GridBloc jobReal3GridBloc;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setSelectedCOB();
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    jobReal3CariBloc = BlocProvider.of<JobReal3CariBloc>(context);
    jobReal3GridBloc = BlocProvider.of<JobReal3GridBloc>(context);
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
    jobReal3CariBloc.add(RefreshJobReal3CariEvent(
        jobreal1Id: widget.jobReal1Id,
        searchText: _searchController.text,
        hal: 0));
  }

  void setSelectedCOB() {
    if (jobReal3GridBloc.state.items.isNotEmpty) {
      jobReal3CariBloc.add(InitialSelectedCOBJobReal3Event(
          selectedCOB: jobReal3GridBloc.state.items));
    }
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {
          debugPrint("_searchController.text : ${_searchController.text}");
          jobReal3CariBloc.add(RefreshJobReal3CariEvent(
              jobreal1Id: widget.jobReal1Id,
              searchText: _searchController.text,
              hal: 0));
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        JobReal3CariListWidget(
            jobReal1Id: widget.jobReal1Id, searchText: _searchController.text)
      ],
    ));
  }
}

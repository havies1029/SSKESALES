import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_list_widget.dart';

class JobReal2CariPage extends StatefulWidget {
  final String custId;
  final String jobCatId;
  final String jobReal1Id;
  const JobReal2CariPage({super.key, required this.custId,
    required this.jobCatId, required this.jobReal1Id});

  @override
  JobReal2CariPageState createState() => JobReal2CariPageState();
}

class JobReal2CariPageState extends State<JobReal2CariPage> {
  late JobReal2CariBloc jobReal2CariBloc;
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
    jobReal2CariBloc = BlocProvider.of<JobReal2CariBloc>(context);
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
    if (widget.custId.isNotEmpty) {
      jobReal2CariBloc.add(RefreshJobReal2CariEvent(
          custId: widget.custId, jobcatId: widget.jobCatId, 
          jobreal1Id: widget.jobReal1Id));
    }
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {          
          if (widget.custId.isNotEmpty) {            
            jobReal2CariBloc.add(RefreshJobReal2CariEvent(
              custId: widget.custId, jobcatId: widget.jobCatId, 
              jobreal1Id: widget.jobReal1Id));
          }
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        JobReal2CariListWidget(searchText: _searchController.text)
      ],
    ));
  }
}

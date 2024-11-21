import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/blocs/jobreal/sppa4timelinecari_bloc.dart';
import 'package:esalesapp/pages/jobreal/sppacari_list_widget.dart';

class SppaCariPage extends StatefulWidget {
  final String jobRealId;
  const SppaCariPage({super.key, required this.jobRealId});

  @override
  SppaCariPageState createState() => SppaCariPageState();
}

class SppaCariPageState extends State<SppaCariPage> {
  late Sppa4TimelineCariBloc sppaCariBloc;
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
    debugPrint("SppaCariPageState -> build #10");

    sppaCariBloc = BlocProvider.of<Sppa4TimelineCariBloc>(context);
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
    debugPrint("SppaCariPageState -> refreshData #10");
    sppaCariBloc.add(RefreshSppaCariEvent(
        jobRealId: widget.jobRealId, searchText: _searchController.text));
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {
          sppaCariBloc.add(RefreshSppaCariEvent(
              jobRealId: widget.jobRealId, searchText: _searchController.text));
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SppaCariListWidget(
            jobRealId: widget.jobRealId, searchText: _searchController.text)
      ],
    ));
  }
}

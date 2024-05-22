import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcrud_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_list_widget.dart';

class JobRealCariPage extends StatefulWidget {
  const JobRealCariPage({super.key});

  @override
  JobRealCariPageState createState() => JobRealCariPageState();
}

class JobRealCariPageState extends State<JobRealCariPage> {
  late JobRealCariBloc jobRealCariBloc;
  late JobRealCrudBloc jobRealCrudBloc;
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
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<JobRealCariBloc, JobRealCariState>(
              listener: (context, state) {
            if (state.viewMode == "tambah") {
              showDialogViewData(context, state.viewMode, "");
            } else if (state.viewMode == "ubah") {
              showDialogViewData(context, state.viewMode, state.recordId);
            }
          }, listenWhen: (previous, current) {
            return previous.viewMode != current.viewMode;
          }),
          BlocListener<JobRealCrudBloc, JobRealCrudState>(
              listener: (context, state) {
            if (state.isSaved) {
              refreshData();
            }
          }, listenWhen: (previous, current) {
            return previous.isSaved != current.isSaved;
          }),
        ],
        child: Scaffold(
          floatingActionButton:
              FloatingMenuMasterWidget(onTambah: onTambahData),
          body: Container(
            color: Colors.grey[200],
            child: Center(
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
          ),
        ));
  }

  void refreshData() {
    jobRealCariBloc.add(
        RefreshJobRealCariEvent(searchText: _searchController.text, hal: 0));
  }

  void onTambahData() {
    jobRealCariBloc.add(TambahJobRealCariEvent());
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {
          jobRealCariBloc.add(RefreshJobRealCariEvent(
              searchText: _searchController.text, hal: 0));
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        JobRealCariListWidget(searchText: _searchController.text)
      ],
    ));
  }

  void showDialogViewData(
      BuildContext context, String viewMode, String recordId) {
    FocusScope.of(context).requestFocus(FocusNode());
    resetFormState(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        jobRealCrudBloc.add(JobRealCrudPreOpenEvent(viewmode: viewMode));        
        return JobRealCrudMainPage(viewMode: viewMode, recordId: recordId);
      }),
    ).then((value) {
      return jobRealCariBloc.add(CloseDialogJobRealCariEvent());
    });
  }

  void resetFormState(BuildContext context) {
    debugPrint("JobRealCariPage -> resetFormState #10");

    jobRealCrudBloc.add(JobRealCrudResetStateEvent());

    BlocProvider.of<JobReal2CariBloc>(context)
        .add(ResetStateJobReal2CariEvent());
    BlocProvider.of<JobRealFotoBloc>(context).add(ResetStateJobRealFotoEvent());
    BlocProvider.of<JobRealCariBloc>(context).add(ResetStateJobRealCariEvent());
    BlocProvider.of<JobReal2GridBloc>(context)
        .add(ResetStateJobReal2ListEvent());
  }
}

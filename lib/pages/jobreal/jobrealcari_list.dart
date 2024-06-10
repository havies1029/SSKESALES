import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
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
  String filterList = "all";

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
            } else if (state.viewMode == "lihat") {
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
                  buildBtnFilter(),
                  buildList()
                ],
              ),
            ),
          ),
        ));
  }

  void refreshData() {
    jobRealCariBloc.add(RefreshJobRealCariEvent(
        searchText: _searchController.text, hal: 0, filterDoc: filterList));
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
              searchText: _searchController.text,
              hal: 0,
              filterDoc: filterList));
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
    BlocProvider.of<JobReal3CariBloc>(context)
        .add(ResetStateJobReal3CariEvent());
    BlocProvider.of<JobRealFotoBloc>(context).add(ResetStateJobRealFotoEvent());
    BlocProvider.of<JobRealCariBloc>(context).add(ResetStateJobRealCariEvent());
    BlocProvider.of<JobReal2GridBloc>(context)
        .add(ResetStateJobReal2ListEvent());
    BlocProvider.of<JobReal3GridBloc>(context)
        .add(ResetStateJobReal3ListEvent());
  }

  Widget buildBtnFilter() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: AppData.kIsWeb?80:MediaQuery.of(context).size.width * 0.25,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filterList = "all";
                      });
                      jobRealCariBloc
                          .add(const SetFilterDocRealCariEvent(filterDoc: "all"));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.green[500],                  
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'All',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: AppData.kIsWeb?100:MediaQuery.of(context).size.width * 0.25,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filterList = "draft";
                      });
                      jobRealCariBloc
                          .add(const SetFilterDocRealCariEvent(filterDoc: "draft"));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.orange[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Draft',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: AppData.kIsWeb?130:MediaQuery.of(context).size.width * 0.3,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filterList = "confirmed";
                      });
                      jobRealCariBloc.add(
                          const SetFilterDocRealCariEvent(filterDoc: "confirmed"));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor:
                          Colors.blueGrey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Confirmed',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: AppData.kIsWeb?80:MediaQuery.of(context).size.width * 0.25,
                height: 23,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 10),
                  child: filterList == "all" ? Container(color: Colors.red[500]):Container()
                ),
              ),
              SizedBox(
                width: AppData.kIsWeb?100:MediaQuery.of(context).size.width * 0.25,
                height: 23,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, right: 10),
                  child: filterList == "draft" ? Container(color: Colors.red[500]):Container()
                  ),
                ),              
                SizedBox(
                  width: AppData.kIsWeb?130:MediaQuery.of(context).size.width * 0.3,
                  height: 23,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),                  
                    child: filterList == "confirmed" ? Container(color: Colors.red[500]):Container()
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealbtnfilter_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/pages/jobreal/jobrealbtnfilter_widget.dart';
import 'package:esalesapp/pages/jobreal/jobrealcrud_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_list_widget.dart';

class JobRealCariPage extends StatefulWidget {
  final bool readOnly;
  final String personId;
  final ComboJobcatgroupModel selectedJobCatGroup;
  const JobRealCariPage(
      {super.key, required this.personId, required this.readOnly, required this.selectedJobCatGroup});

  @override
  JobRealCariPageState createState() => JobRealCariPageState();
}

class JobRealCariPageState extends State<JobRealCariPage> {
  late JobRealCariBloc jobRealCariBloc;
  late JobRealCrudBloc jobRealCrudBloc;
  late JobRealGlobalCubit jobRealGlobalCubit;
  late JobRealBtnFilterCubit jobRealBtnFilterCubit;
  final TextEditingController _searchController = TextEditingController();
  //String filterList = "all";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);
    jobRealBtnFilterCubit = BlocProvider.of<JobRealBtnFilterCubit>(context);
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<JobRealCariBloc, JobRealCariState>(
            listener: (context, state) {
              //debugPrint("MultiBlocListener -> JobRealCariBloc");

              if (state.viewMode == "tambah") {
                showDialogViewData(context, state.viewMode, "");
              } else if (state.viewMode == "ubah") {
                showDialogViewData(context, state.viewMode, state.recordId);
              } else if (state.viewMode == "lihat") {
                showDialogViewData(context, state.viewMode, state.recordId);
              }

              //debugPrint("state.isDuplicated : ${state.isDuplicated}");
              if (state.isDuplicated) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Data sudah berhasil diduplikasi."),
                  backgroundColor: Colors.green,
                ));
              }
              else if (state.isMovedNextFlow){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Task berikutnya sudah berhasil dibuat."),
                  backgroundColor: Colors.green,
                ));
              }
            },
          ),
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
          floatingActionButton: widget.readOnly
              ? null
              : FloatingMenuMasterWidget(onTambah: onTambahData),
          body: Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListPageFilterBarUIWidget(
                      searchController: _searchController,
                      searchButton: buildSearchButton()),
                  JobRealBtnFilterWidget(personId: widget.personId),
                  //buildBtnFilter(),
                  buildList()
                ],
              ),
            ),
          ),
        ));
  }

  void refreshData() {

    debugPrint("jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId : ${jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId}");

    jobRealCariBloc.add(RefreshJobRealCariEvent(
        personId: widget.personId,
        jobCatGroupId: jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId,
        searchText: _searchController.text,
        hal: 0,
        filterDoc: jobRealBtnFilterCubit.state.filterDoc));
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
              personId: widget.personId,
              jobCatGroupId: jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId,
              searchText: _searchController.text,
              hal: 0,
              filterDoc: jobRealBtnFilterCubit.state.filterDoc));
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        JobRealCariListWidget(
          personId: widget.personId,          
          searchText: _searchController.text,
          readOnly: widget.readOnly, 
        )
      ],
    ));
  }

  void showDialogViewData(
      BuildContext context, String viewMode, String recordId) {
    FocusScope.of(context).requestFocus(FocusNode());
    resetFormState();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        jobRealCrudBloc.add(JobRealCrudPreOpenEvent(viewmode: viewMode));
        return JobRealCrudMainPage(viewMode: viewMode, 
          recordId: recordId, 
          isBriefingHarianMode: false, 
          isSOAClientMode: false,
          isProjectMode: false,);
      }),
    ).then((value) {
      return jobRealCariBloc.add(CloseDialogJobRealCariEvent());
    });
  }

  
  void resetFormState() {
    debugPrint("JobRealCariPage -> resetFormState #10");

    jobRealCrudBloc.add(JobRealCrudResetStateEvent());

    BlocProvider.of<JobReal2CariBloc>(context)
        .add(ResetStateJobReal2CariEvent());
    BlocProvider.of<JobReal3CariBloc>(context)
        .add(ResetStateJobReal3CariEvent());
    BlocProvider.of<JobRealFotoBloc>(context).add(ResetStateJobRealFotoEvent());
    BlocProvider.of<JobRealCariBloc>(context)
        .add(ResetStateJobRealCariEvent(personId: widget.personId));
    BlocProvider.of<JobReal2GridBloc>(context)
        .add(ResetStateJobReal2ListEvent());
    BlocProvider.of<JobReal3GridBloc>(context)
        .add(ResetStateJobReal3ListEvent());
  }  
  
}

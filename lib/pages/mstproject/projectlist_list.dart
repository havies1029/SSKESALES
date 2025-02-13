import 'package:esalesapp/blocs/mstproject/projectlist_filter_cubit.dart';
import 'package:esalesapp/pages/mstproject/projectlist_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstproject/projectlist_bloc.dart';
import 'package:esalesapp/blocs/mstproject/projectcrud_bloc.dart';
import 'package:esalesapp/pages/mstproject/projectcrud_form.dart';
import 'package:esalesapp/pages/mstproject/projectlist_list_widget.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  ProjectListPageState createState() => ProjectListPageState();
}

class ProjectListPageState extends State<ProjectListPage> {
  late ProjectListBloc projectListBloc;
  late ProjectCrudBloc projectCrudBloc;
  late ProjectlistFilterCubit barCubit;
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
    projectListBloc = BlocProvider.of<ProjectListBloc>(context);
    projectCrudBloc = BlocProvider.of<ProjectCrudBloc>(context);
    barCubit = BlocProvider.of<ProjectlistFilterCubit>(context);
    return MultiBlocListener(
        listeners: [
          BlocListener<ProjectListBloc, ProjectListState>(
              listener: (context, state) {
            if (state.viewMode == "tambah") {
              showDialogViewData(context, state.viewMode, "");
            } else if (state.viewMode == "ubah") {
              showDialogViewData(context, state.viewMode, state.recordId);
            }
          }, listenWhen: (previous, current) {
            return previous.viewMode != current.viewMode;
          }),
          BlocListener<ProjectCrudBloc, ProjectCrudState>(
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [ProjectlistFilterBar(), buildList()],
            ),
          ),
        ));
  }

  void onTambahData() {
    projectListBloc.add(TambahProjectListEvent());
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ProjectListListWidget(searchText: _searchController.text)
      ],
    ));
  }

  void showDialogViewData(
      BuildContext context, String viewMode, String recordId) {
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return ProjectCrudFormPage(
                  viewMode: viewMode, recordId: recordId);
            },
            useSafeArea: true)
        .then((value) {
      projectListBloc.add(CloseDialogProjectListEvent());
    });
  }

  void refreshData() {
    projectListBloc.add(RefreshProjectListEvent(rekanId: "", searchText: ""));
  }
}

import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/pages/mstrekan/rekancrud_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstrekan/rekancari_bloc.dart';
import 'package:esalesapp/blocs/mstrekan/rekancrud_bloc.dart';
import 'package:esalesapp/pages/mstrekan/rekancari_list_widget.dart';

class RekanCariPage extends StatefulWidget {
  final String rekanTypeId;
  const RekanCariPage({super.key, required this.rekanTypeId});

  @override
  RekanCariPageState createState() => RekanCariPageState();
}

class RekanCariPageState extends State<RekanCariPage> {
  late RekanCariBloc rekanCariBloc;
  late RekanCrudBloc rekanCrudBloc;
  final TextEditingController _searchController = TextEditingController();
  //String filterBy = "all";

  @override
  void initState() {
    debugPrint("RekanCariPage initState rekanTypeId : ${widget.rekanTypeId}");

    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData(widget.rekanTypeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("RekanCariPage build rekanTypeId : ${widget.rekanTypeId}");

    rekanCariBloc = BlocProvider.of<RekanCariBloc>(context);
    rekanCrudBloc = BlocProvider.of<RekanCrudBloc>(context);

    return MultiBlocListener(
        listeners: [          
          BlocListener<RekanCariBloc, RekanCariState>(
              listener: (context, state) {
            if (state.viewMode == "tambah") {
              showDialogViewData(context, state.viewMode, "");
            } else if (state.viewMode == "ubah") {
              showDialogViewData(context, state.viewMode, state.recordId);
            }
          }, listenWhen: (previous, current) {
            return previous.viewMode != current.viewMode;
          }),
          BlocListener<RekanCrudBloc, RekanCrudState>(
              listener: (context, state) {
            if (state.isSaved) {
              refreshData(widget.rekanTypeId);
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
              children: [
                ListPageFilterBarUIWidget(
                    searchController: _searchController,
                    searchButton: buildSearchButton()),
                buildBtnFilter(),
                buildList()
              ],
            ),
          ),
        ));
  }

  void refreshData(String rekanTypeId) {
    debugPrint("RekanCariPage -> refreshData");
    rekanCariBloc.add(RefreshRekanCariEvent(
        rekanTypeId: rekanTypeId,
        searchText: _searchController.text,
        hal: 0,
        filterBy: rekanCariBloc.state.filterBy));
  }

  void onTambahData() {
    rekanCariBloc.add(TambahRekanCariEvent());
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {
          rekanCariBloc.add(RefreshRekanCariEvent(
              rekanTypeId: widget.rekanTypeId,
              searchText: _searchController.text,
              hal: 0,
              filterBy: rekanCariBloc.state.filterBy));
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RekanCariListWidget(
            rekanTypeId: widget.rekanTypeId, searchText: _searchController.text)
      ],
    ));
  }


  void showDialogViewData(
      BuildContext context, String viewMode, String recordId) {
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return RekanCrudMainPage(
          rekanTypeId: widget.rekanTypeId,
          viewMode: viewMode,
          recordId: recordId);
      }),
    );

  }

  Widget buildBtnFilter() {
    return BlocBuilder<RekanCariBloc, RekanCariState>(
        buildWhen: (previous, current) {
      return (previous.filterBy != current.filterBy);
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppData.kIsWeb
                      ? 80
                      : MediaQuery.of(context).size.width * 0.25,
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Press Btn Filter All");
                        //_searchController.text = "";
                        rekanCariBloc.add(RefreshRekanCariEvent(
                            rekanTypeId: widget.rekanTypeId,
                            searchText: "",
                            hal: 0,
                            filterBy: "all"));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green[500],
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
                  width: AppData.kIsWeb
                      ? 130
                      : MediaQuery.of(context).size.width * 0.35,
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Press Btn Filter Unassigned");

                        rekanCariBloc.add(RefreshRekanCariEvent(
                            rekanTypeId: widget.rekanTypeId,
                            searchText: "",
                            hal: 0,
                            filterBy: "unassigned"));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Unassigned',
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
                  width: AppData.kIsWeb
                      ? 80
                      : MediaQuery.of(context).size.width * 0.25,
                  height: 23,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 10),
                      child: state.filterBy == "all"
                          ? Container(color: Colors.red[500])
                          : Container()),
                ),
                SizedBox(
                  width: AppData.kIsWeb
                      ? 130
                      : MediaQuery.of(context).size.width * 0.35,
                  height: 23,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, right: 10),
                      child: state.filterBy == "unassigned"
                          ? Container(color: Colors.red[500])
                          : Container()),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstrekan/rekancari_bloc.dart';
import 'package:esalesapp/blocs/mstrekan/rekancrud_bloc.dart';
import 'package:esalesapp/pages/mstrekan/rekancrud_form.dart';
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
                buildList()
              ],
            ),
          ),
        ));
  }

  void refreshData(String rekanTypeId) {
    rekanCariBloc.add(RefreshRekanCariEvent(
        rekanTypeId: rekanTypeId, searchText: _searchController.text, hal: 0));
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
              hal: 0));
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
    showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return RekanCrudFormPage(rekanTypeId: widget.rekanTypeId, viewMode: viewMode, recordId: recordId);
            },
            useSafeArea: true)
        .then((value) {
      rekanCariBloc.add(CloseDialogRekanCariEvent());
    });
  }
}

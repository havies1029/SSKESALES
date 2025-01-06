import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/listpage_filter_bar_ui.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstmedia/mediacari_bloc.dart';
import 'package:esalesapp/blocs/mstmedia/mediacrud_bloc.dart';
import 'package:esalesapp/pages/mstmedia/mediacrud_form.dart';
import 'package:esalesapp/pages/mstmedia/mediacari_list_widget.dart';

class MediaCariPage extends StatefulWidget {
  const MediaCariPage({super.key});

  @override
  MediaCariPageState createState() => MediaCariPageState();
}

class MediaCariPageState extends State<MediaCariPage> {
  late MediaCariBloc mediaCariBloc;
  late MediaCrudBloc mediaCrudBloc;
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
    mediaCariBloc = BlocProvider.of<MediaCariBloc>(context);
    mediaCrudBloc = BlocProvider.of<MediaCrudBloc>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<MediaCariBloc, MediaCariState>(
              listener: (context, state) {
            if (state.viewMode == "tambah") {
              showDialogViewData(context, state.viewMode, "");
            } else if (state.viewMode == "ubah") {
              showDialogViewData(context, state.viewMode, state.recordId);
            }
          }, listenWhen: (previous, current) {
            return previous.viewMode != current.viewMode;
          }),
          BlocListener<MediaCrudBloc, MediaCrudState>(
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
    mediaCariBloc
        .add(RefreshMediaCariEvent(searchText: _searchController.text, hal: 0));
  }

  void onTambahData() {
    mediaCariBloc.add(TambahMediaCariEvent());
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {
          refreshData();
          
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        MediaCariListWidget(searchText: _searchController.text)
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
              return MediaCrudFormPage(viewMode: viewMode, recordId: recordId);
            },
            useSafeArea: true)
        .then((value) {
      mediaCariBloc.add(CloseDialogMediaCariEvent());
    });
  }
}

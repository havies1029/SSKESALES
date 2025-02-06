import 'package:esalesapp/pages/mstrekan/rekancontactcrud_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/floatingmenumaster_widget.dart';
import 'package:esalesapp/blocs/mstrekan/rekancontactlist_bloc.dart';
import 'package:esalesapp/blocs/mstrekan/rekancontactcrud_bloc.dart';
import 'package:esalesapp/pages/mstrekan/rekancontactlist_list_widget.dart';

class RekanContactListPage extends StatefulWidget {  
  final String mrekanId;
	const RekanContactListPage({super.key, required this.mrekanId});

	@override
	RekanContactListPageState createState() => RekanContactListPageState();
}

class RekanContactListPageState extends State<RekanContactListPage> {
	late RekanContactListBloc rekanContactListBloc;
	late RekanContactCrudBloc rekanContactCrudBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		rekanContactListBloc = BlocProvider.of<RekanContactListBloc>(context);
		rekanContactCrudBloc = BlocProvider.of<RekanContactCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<RekanContactListBloc, RekanContactListState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<RekanContactCrudBloc, RekanContactCrudState>(
					listener: (context, state) {
						if (state.isSaved) {
							refreshData();
						}
				}, listenWhen: (previous, current) {
					return previous.isSaved != current.isSaved;
				}),
			],
			child: Scaffold(
				floatingActionButton: FloatingMenuMasterWidget(
					onTambah: onTambahData),
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: [							
							buildList()
						],

					),
				),
			));
	}

	void refreshData() {
		rekanContactListBloc.add(
			RefreshRekanContactListEvent(mrekanId: widget.mrekanId));
	}

	void onTambahData() {
		rekanContactListBloc.add(TambahRekanContactListEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			rekanContactListBloc.add(RefreshRekanContactListEvent(
				mrekanId: widget.mrekanId));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[RekanContactListListWidget()],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return RekanContactCrudFormPage(viewMode: viewMode, mrekanId: widget.mrekanId, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			rekanContactListBloc.add(CloseDialogRekanContactListEvent());
		});
	}

}

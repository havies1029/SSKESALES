import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/jobreal/jobrealcrud_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/soaclient/dnlist_bloc.dart';
import 'package:esalesapp/pages/soaclient/dnlist_tile_widget.dart';
import 'package:esalesapp/models/soaclient/dnlist_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DnlistListWidget extends StatefulWidget {
	final String searchText;
	const DnlistListWidget({super.key, required this.searchText});

	@override
	DnlistListWidgetState createState() => DnlistListWidgetState();
}

class DnlistListWidgetState extends State<DnlistListWidget> {
	late DnlistBloc dnlistBloc;
  late JobRealCariBloc jobRealCariBloc;
  late JobRealCrudBloc jobRealCrudBloc;
  late JobRealFotoBloc jobRealFotoBloc;
	List<DnlistModel> dnlist = [];
	final ScrollController _scrollController = ScrollController();

	@override
	void initState() {
		super.initState();
		_scrollController.addListener(_onScroll);
	}

	@override
	void dispose() {
		_scrollController
			..removeListener(_onScroll)
			..dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		dnlistBloc = BlocProvider.of<DnlistBloc>(context);
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);
    jobRealFotoBloc = BlocProvider.of<JobRealFotoBloc>(context);
		return BlocConsumer<DnlistBloc, DnlistState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				dnlist.addAll(state.items);
			}

		return state.items.isNotEmpty
			? Flexible(
				child: ListView.builder(
					padding: EdgeInsets.zero,
					controller: _scrollController,
					itemCount: state.items.length,
					itemBuilder: (_, index) => Container(
						margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
						padding: const EdgeInsets.all(0.2),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(15.0)),
						child: Slidable(
              endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialogViewData(context,
                            state.items[index], index);
                      },
                      backgroundColor: Colors.green,
                      icon: Icons.edit,
                      label: "Add Task",
                    ),
                  ]),
                child: DnlistTileWidget(
                  dnAmount: state.items[index].dnAmount,
                  dnBayar: state.items[index].dnBayar,
                  dnTgl: state.items[index].dnTgl,
                  dn1Id: state.items[index].dn1Id,
                  extDate: state.items[index].extDate,
                  jthTempo: state.items[index].jthTempo,
                  curr: state.items[index].curr,
                  sppaNo: state.items[index].sppaNo, 
                    insuredName: state.items[index].insuredName, 
                    cobName: state.items[index].cobName, 
                    severity: state.items[index].severity, 
                    aging: state.items[index].aging,
                ),
              ),
					)),
				)
			: const Center(
				child: Padding(
					padding: EdgeInsets.only(top: 80.0),
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				),
			);
		} else {
			return const Center(
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				);
			}
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			dnlistBloc.add(FetchDnlistEvent(
				));
		}
	}

  void showDialogViewData(
      BuildContext context, DnlistModel item, int selectedIndex) {
    String viewMode = "tambah";
    resetFormJobReal();
    dnlistBloc.add(SetSelectedDNEvent(selectedDNId: item.dn1Id));
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        jobRealCrudBloc.add(JobRealCrudPreOpenEvent(viewmode: viewMode));
        return JobRealCrudMainPage(
          viewMode: viewMode,
          recordId: "",
          isBriefingHarianMode: false,
          isSOAClientMode: true,
        );
      }),
    ).then((value) {
      jobRealCariBloc.add(CloseDialogJobRealCariEvent());
    });
  }

  void resetFormJobReal() {
    jobRealFotoBloc.add(ResetStateJobRealFotoEvent());
  }

}

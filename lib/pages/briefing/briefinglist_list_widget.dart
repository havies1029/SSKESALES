part of 'briefinglist_list.dart';

class BriefinglistListWidget extends StatefulWidget {
  const BriefinglistListWidget({super.key});

  @override
  BriefinglistListWidgetState createState() => BriefinglistListWidgetState();
}

class BriefinglistListWidgetState extends State<BriefinglistListWidget> {
  late JobRealCariBloc jobRealCariBloc;
  late JobRealCrudBloc jobRealCrudBloc;
  late BriefinglistBloc briefinglistBloc;
  late BriefingInfoBloc briefingInfoBloc;
  late JobRealFotoBloc jobRealFotoBloc;
  List<BriefinglistModel> briefinglist = [];
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
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);
    briefinglistBloc = BlocProvider.of<BriefinglistBloc>(context);
    briefingInfoBloc = BlocProvider.of<BriefingInfoBloc>(context);
    jobRealFotoBloc = BlocProvider.of<JobRealFotoBloc>(context);
    return BlocConsumer<BriefinglistBloc, BriefinglistState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            if (!state.hasReachedMax) {
              briefinglist.addAll(state.items);
            }

            return state.items.isNotEmpty
                ? Flexible(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        itemCount: state.items.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
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
                                        label:
                                            "${state.items[index].jobreal1Id.isEmpty ? "Add" : state.items[index].confirmed ? "View" : "Edit"} Task}",
                                      ),
                                    ]),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.white,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  elevation: 2,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ListTile(
                                    title: Text(
                                      state.items[index].jobNama,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    tileColor: Colors.blueGrey,
                                    trailing: state.items[index].confirmed
                                        ? const Icon(
                                            Icons.check_box,
                                            color: Colors.greenAccent,
                                          )
                                        : const Icon(
                                            Icons.check_box_outline_blank,
                                            color: Colors.greenAccent,
                                          ),
                                  ),
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
        },
        buildWhen: (previous, current) {
          return (current.status == ListStatus.success);
        },
        listener: (context, state) {});
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      briefinglistBloc.add(FetchBriefinglistEvent());
    }
  }

  void showDialogViewData(
      BuildContext context, BriefinglistModel item, int selectedIndex) {
    String viewMode = item.jobreal1Id?.isNotEmpty ?? true
        ? (item.confirmed ? "lihat" : "ubah")
        : "tambah";
    refreshFormJobReal();
    briefingInfoBloc.add(SetSelectedItemBriefingInfoEvent(selectedItem: item));
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        jobRealCrudBloc.add(JobRealCrudPreOpenEvent(viewmode: viewMode));
        return JobRealCrudMainPage(
          viewMode: viewMode,
          recordId: item.jobreal1Id,
          isBriefingHarianMode: true,
          isSOAClientMode: false,
          isProjectMode: false,
        );
      }),
    ).then((value) {
      jobRealCariBloc.add(CloseDialogJobRealCariEvent());
    });
  }

  void refreshFormJobReal() {
    jobRealFotoBloc.add(ResetStateJobRealFotoEvent());
  }
}

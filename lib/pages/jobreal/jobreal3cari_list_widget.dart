import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/jobreal/jobreal3cari_model.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';

class JobReal3CariListWidget extends StatefulWidget {
  final String jobReal1Id;
  final String searchText;
  const JobReal3CariListWidget({super.key, 
    required this.searchText, required this.jobReal1Id});

  @override
  JobReal3CariListWidgetState createState() => JobReal3CariListWidgetState();
}

class JobReal3CariListWidgetState extends State<JobReal3CariListWidget> {
  late JobReal3CariBloc jobReal3CariBloc;
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
    jobReal3CariBloc = BlocProvider.of<JobReal3CariBloc>(context);
    return BlocConsumer<JobReal3CariBloc, JobReal3CariState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
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
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Checkbox(
                                            value: state
                                                .items[index].isChecked,
                                            onChanged: (val) {
                                              JobReal3CariModel item = state.items[index];
                                              jobReal3CariBloc.add(
                                                  UpdateCheckboxJobReal3Event(
                                                      jobReal3Item: item,
                                                      isChecked: val!));
                                            }),
                                      ),
                                      Flexible(
                                        flex: 9,
                                        child: Text(
                                          state.items[index].cobNama,
                                          style: MyText.bodyLarge(context)!
                                            .copyWith(color: MyColors.grey_80)),
                                      ),
                                      
                                    ],
                                  )
                                ],
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
        listener: (context, state) {
          if (state.requestToUpdate) {
          debugPrint("state.requestToUpdate : ${state.requestToUpdate}");
          var viewMode = context.read<JobRealCrudBloc>().state.viewMode;
          debugPrint("viewMode : $viewMode");
          if (viewMode == "ubah") {
            jobReal3CariBloc
                .add(Update2ApiJobReal3Event(jobreal1Id: widget.jobReal1Id));
          } else {
            _dismissDialog();
          }
        } else if (state.isSaved) {
          _dismissDialog();
        }
        if (state.status == ListStatus.success) {
          /*
                listCheckbox = List<JobReal2CariCheckboxModel>.generate(
                  state.items.length, (index) => 
                  JobReal2CariCheckboxModel(polis1Id: state.items[index].polis1Id, 
                  isChecked: state.items[index].isChecked);
                */
        }
      },
      listenWhen: (previous, current) {
        //debugPrint("JobReal3CariBloc listenWhen current.requestToUpdate : ${current.requestToUpdate}");
        return (current.requestToUpdate || (current.isSaved));
      },
    );
  }

  void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			jobReal3CariBloc.add(FetchJobReal3CariEvent(jobreal1Id: widget.jobReal1Id,
				searchText: widget.searchText, hal: jobReal3CariBloc.state.hal));
		}
	}

  void _dismissDialog() {
    Navigator.pop(context);
  }
}

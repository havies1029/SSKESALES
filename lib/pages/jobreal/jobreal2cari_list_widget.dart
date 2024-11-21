import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_tile_widget.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:string_validator/string_validator.dart';

class JobReal2CariListWidget extends StatefulWidget {
  final String jobReal1Id;
  final String searchText;
  const JobReal2CariListWidget(
      {super.key, required this.jobReal1Id, required this.searchText});

  @override
  JobReal2CariListWidgetState createState() => JobReal2CariListWidgetState();
}

class JobReal2CariListWidgetState extends State<JobReal2CariListWidget> {
  late JobReal2CariBloc jobReal2CariBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    jobReal2CariBloc = BlocProvider.of<JobReal2CariBloc>(context);
    return BlocConsumer<JobReal2CariBloc, JobReal2CariState>(
      builder: (context, state) {
        if (state.status == ListStatus.success) {
          if (!state.hasReachedMax) {
            //debugPrint("builder #10");
            //jobReal2List = state.items;
          }

          //var elements = jobReal2List.map((e) => e.toJson()).toList();
          var elements = state.items.map((e) => e.toJson()).toList();

          //debugPrint("builder #20");

          //debugPrint("elements : $elements");

          return state.items.isNotEmpty
              ? Flexible(
                  child: Container(
                  color: Colors.grey[200],
                  child: GroupedListView<dynamic, String>(
                    controller: _scrollController,
                    elements: elements,
                    groupBy: (elements) => elements['cob'],
                    groupComparator: (value1, value2) =>
                        value1.compareTo(value2),
                    itemComparator: (item1, item2) =>
                        item1['polis1Id'].compareTo(item2['polis1Id']),
                    order: GroupedListOrder.ASC,
                    useStickyGroupSeparators: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          //color: Colors.blueGrey,
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    indexedItemBuilder: (c, element, index) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          side: BorderSide(
                            color: Colors.purple.withOpacity(0.7),
                            width: 0.6,
                          ),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Checkbox(
                                  value: toBoolean(
                                      element["isChecked"].toString()),
                                  onChanged: (val) {
                                    JobReal2CariModel item =
                                        JobReal2CariModel.fromJson(element);

                                    jobReal2CariBloc.add(
                                        UpdateCheckboxJobReal2Event(
                                            jobReal2Item: item,
                                            isChecked: val!));
                                  }),
                            ),
                            SizedBox(
                                height: 220,
                                child: VerticalDivider(
                                  thickness: 3.0,
                                  color: Colors.grey[200],
                                )),
                            Flexible(
                              flex: 9,
                              child: JobReal2CariTileWidget(
                                polis1Id: element["polis1Id"],
                                polisNo: element["polisNo"],
                                sppaNo: element["sppaNo"],
                                periodeAwal:
                                    DateTime.parse(element["periodeAwal"]),
                                periodeAkhir:
                                    DateTime.tryParse(element["periodeAkhir"]),
                                curr: element["curr"],
                                cstPremi: double.parse(element["cstPremi"]),
                                tsi: double.parse(element["tsi"]),
                                cob: element["cob"],
                                insuredNama: element["insuredNama"],
                                jobreal2Id: element["jobreal2Id"],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ))
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
          debugPrint("JobReal2CariListWidget -> viewMode : $viewMode");
          if (viewMode == "ubah") {
            jobReal2CariBloc
                .add(Update2ApiJobReal2Event(jobreal1Id: widget.jobReal1Id));

          }
        }
      },
      listenWhen: (previous, current) {
        //debugPrint("JobReal2CariBloc listenWhen current.requestToUpdate : ${current.requestToUpdate}");
        return (current.requestToUpdate || (current.isSaved));
      },
    );
  }

}

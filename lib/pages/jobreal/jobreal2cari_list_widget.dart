import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_tile_widget.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:grouped_list/grouped_list.dart';

class JobReal2CariListWidget extends StatefulWidget {
	final String searchText;
	const JobReal2CariListWidget({super.key, required this.searchText});

	@override
	JobReal2CariListWidgetState createState() => JobReal2CariListWidgetState();
}

class JobReal2CariListWidgetState extends State<JobReal2CariListWidget> {
	late JobReal2CariBloc jobReal2CariBloc;
	
	@override
	void initState() {
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		jobReal2CariBloc = BlocProvider.of<JobReal2CariBloc>(context);
		return BlocConsumer<JobReal2CariBloc, JobReal2CariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {

    var elements = state.items.map((e) => e.toJson()).toList();
		return state.items.isNotEmpty
			? Flexible(
				child: Container(
      color: Colors.grey[200],
      child: GroupedListView<dynamic, String>(
        elements: elements,
        groupBy: (elements) => elements['cob'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
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
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        indexedItemBuilder: (c, element, index) {
          return JobReal2CariTileWidget(
            polis1Id: element["polis1Id"],
            polisNo: element["polisNo"],
            periodeAwal: DateTime.parse(element["periodeAwal"]),
            periodeAkhir: DateTime.parse(element["periodeAkhir"]),
            curr: element["curr"],
            cstPremi: double.parse(element["cstPremi"]),
            tsi: double.parse(element["tsi"]),
            cob: element["cob"],
            insuredNama: element["insuredNama"],
            jobreal2Id: element["jobreal2Id"],
            );
        },
      ),
    )
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

}

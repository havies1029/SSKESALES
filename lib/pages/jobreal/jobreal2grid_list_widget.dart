import 'package:esalesapp/blocs/jobreal/jobreal2list_bloc.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal2grid_tile_widget.dart';

class JobReal2GridListWidget extends StatefulWidget {
	const JobReal2GridListWidget({super.key});

	@override
	JobReal2GridListWidgetState createState() => JobReal2GridListWidgetState();
}

class JobReal2GridListWidgetState extends State<JobReal2GridListWidget> {
	late JobReal2ListBloc jobReal2GridBloc;
	List<JobReal2CariModel> jobReal2Grid = [];
	final ScrollController _scrollController = ScrollController();


	@override
	Widget build(BuildContext context) {
		jobReal2GridBloc = BlocProvider.of<JobReal2ListBloc>(context);
		return BlocConsumer<JobReal2ListBloc, JobReal2ListState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				jobReal2Grid.addAll(state.items);
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
						child: Column(
							children: <Widget>[
								JobReal2GridTileWidget(
									polis1Id: state.items[index].polis1Id,
									polisNo: state.items[index].polisNo,
									periodeAwal: state.items[index].periodeAwal,
									periodeAkhir: state.items[index].periodeAkhir,
									curr: state.items[index].curr,
									cstPremi: state.items[index].cstPremi,
									tsi: state.items[index].tsi,
									cob: state.items[index].cob,
									insuredNama: state.items[index].insuredNama,
									jobreal2Id: state.items[index].jobreal2Id,
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
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}

}

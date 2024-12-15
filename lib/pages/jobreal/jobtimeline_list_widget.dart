import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/jobreal/jobtimeline_tile_widget.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobtimeline_bloc.dart';
import 'package:esalesapp/models/jobreal/jobtimeline_model.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class JobtimelineListWidget extends StatefulWidget {
	final String jobRealId;  
  final String polisId;
	const JobtimelineListWidget({super.key, required this.jobRealId, required this.polisId});

	@override
	JobtimelineListWidgetState createState() => JobtimelineListWidgetState();
}

class JobtimelineListWidgetState extends State<JobtimelineListWidget> {
	late JobtimelineBloc jobtimelineBloc;
	List<JobtimelineModel> jobtimeline = [];

	@override
	void initState() {
		super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData();
    });
	}

	@override
	Widget build(BuildContext context) {
		jobtimelineBloc = BlocProvider.of<JobtimelineBloc>(context);
		return BlocConsumer<JobtimelineBloc, JobtimelineState>(
			builder: (context, state) {

      if (state.status == ListStatus.success) {
        
        if (!state.hasReachedMax) {
          jobtimeline.addAll(state.items);
        }
      
          return state.items.isNotEmpty
            ? 
            Timeline.tileBuilder(
              padding: const EdgeInsets.all(8.0),
              theme: TimelineThemeData(
                nodePosition: 0,
                color: const Color.fromARGB(255, 152, 152, 152),
                indicatorTheme: const IndicatorThemeData(
                  position: 0,
                  size: 20.0,
                ),
                connectorTheme: const ConnectorThemeData(
                  thickness: 2.5,
                ),
              ),        
              builder: TimelineTileBuilder.connected(
                      connectionDirection: ConnectionDirection.before,
                      indicatorBuilder: (_, index) {
                        if (state.items[index].jobStatus == "Confirmed") {
                          return const DotIndicator(
                            color: Color(0xff66c97f),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12.0,
                            ),
                          );
                        } else {
                          return const OutlinedDotIndicator(
                            borderWidth: 2.5,
                          );
                        }
                      },
                      connectorBuilder: (_, index, ___) => SolidLineConnector(
                        color: (state.items[index].jobStatus == "Confirmed") ? const Color(0xff66c97f) : null,
                      ),
                      contentsAlign: ContentsAlign.basic,
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(DateFormat('dd/MM/yyyy').format(state.items[index].jobTgl),
                                        style: MyText.titleLarge(context)!
                                          .copyWith(color: MyColors.grey_95)),
                                        Text(DateFormat('HH:mm').format(state.items[index].jobTgl),
                                        style: MyText.titleLarge(context)!
                                          .copyWith(color: MyColors.grey_95)),
                                      ],
                                    ),
                                  ),
                                  //const Spacer(),
                                  Flexible(
                                    flex: 2,
                                    child: Text('[${state.items[index].jobIdx}/${state.items[index].totalJob}]',
                                    style: MyText.titleLarge(context)!
                                      .copyWith(color: MyColors.grey_95)),
                                  ),
                                ],
                              ),
                                ),
                            JobtimelineTileWidget(
                              feedback: state.items[index].feedback,
                              jobIdx: state.items[index].jobIdx,
                              jobName: state.items[index].jobName,
                              jobTgl: state.items[index].jobTgl,
                              materi: state.items[index].materi,
                              totalJob: state.items[index].totalJob,
                            ),
                          ],
                        )
                        
                      ),
                itemCount: state.items.length,
              ),
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

  void refreshData() {
    jobtimelineBloc.add(RefreshJobtimelineEvent(jobRealId: widget.jobRealId, polisId: widget.polisId));
  }

  bool isEdgeIndex(int index) {
    return index == 0;
  }

}

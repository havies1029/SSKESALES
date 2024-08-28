import 'package:esalesapp/blocs/jobreal/jobrealbtnfilter_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobRealBtnFilterWidget extends StatefulWidget {  
  final String personId;
  const JobRealBtnFilterWidget({super.key, required this.personId});

  @override
  JobRealBtnFilterWidgetState createState() => JobRealBtnFilterWidgetState();
}

class JobRealBtnFilterWidgetState extends State<JobRealBtnFilterWidget> {
  late JobRealBtnFilterCubit jobRealBtnFilterCubit;
  late JobRealCariBloc jobRealCariBloc;  
  late JobRealGlobalCubit jobRealGlobalCubit;

  @override
  Widget build(BuildContext context) {
    jobRealBtnFilterCubit = BlocProvider.of<JobRealBtnFilterCubit>(context);
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);

    return BlocConsumer<JobRealBtnFilterCubit, JobRealBtnFilterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppData.kIsWeb
                          ? 80
                          : MediaQuery.of(context).size.width * 0.25,
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            /*
                            setState(() {
                              filterList = "all";
                            });
                            jobRealCariBloc.add(
                                const SetFilterDocRealCariEvent(filterDoc: "all"));
                            */
                            jobRealBtnFilterCubit.setSelectedFilterDoc("all");
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'All',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppData.kIsWeb
                          ? 100
                          : MediaQuery.of(context).size.width * 0.25,
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            /*
                            setState(() {
                              filterList = "draft";
                            });
                            jobRealCariBloc.add(
                                const SetFilterDocRealCariEvent(filterDoc: "draft"));
                            */
                            jobRealBtnFilterCubit.setSelectedFilterDoc("draft");
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.orange[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Draft',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppData.kIsWeb
                          ? 130
                          : MediaQuery.of(context).size.width * 0.3,
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            /*
                            setState(() {
                              filterList = "confirmed";
                            });
                            jobRealCariBloc.add(const SetFilterDocRealCariEvent(
                                filterDoc: "confirmed"));
                            */
                            
                            jobRealBtnFilterCubit.setSelectedFilterDoc("confirmed");
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.blueGrey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Confirmed',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppData.kIsWeb
                          ? 80
                          : MediaQuery.of(context).size.width * 0.25,
                      height: 23,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 10),
                          child: state.filterDoc == "all"
                              ? Container(color: Colors.red[500])
                              : Container()),
                    ),
                    SizedBox(
                      width: AppData.kIsWeb
                          ? 100
                          : MediaQuery.of(context).size.width * 0.25,
                      height: 23,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 20.0, right: 10),
                          child: state.filterDoc == "draft"
                              ? Container(color: Colors.red[500])
                              : Container()),
                    ),
                    SizedBox(
                      width: AppData.kIsWeb
                          ? 130
                          : MediaQuery.of(context).size.width * 0.3,
                      height: 23,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: state.filterDoc == "confirmed"
                              ? Container(color: Colors.red[500])
                              : Container()),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        buildWhen: (previous, current) {
          return (previous.filterDoc != current.filterDoc);
        },
        listener: (context, state) {          
          jobRealCariBloc.add(RefreshJobRealCariEvent(
            hal: 0,
            searchText: "",
            filterDoc:  state.filterDoc,
            personId: widget.personId,
            jobCatGroupId: jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId));
            });
  }
}

import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobReal2CariMainPage extends StatefulWidget {
  final String custId;
  final String custName;
  final String jobReal1Id;
  const JobReal2CariMainPage(
      {super.key,
      required this.custId,
      required this.jobReal1Id,
      required this.custName});

  @override
  JobReal2CariMainPageState createState() => JobReal2CariMainPageState();
}

class JobReal2CariMainPageState extends State<JobReal2CariMainPage> {
  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Daftar Polis'),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
              tooltip: 'Save',
              onPressed: () {
                JobReal2CariBloc jobReal2CariBloc =
                    BlocProvider.of<JobReal2CariBloc>(context);
                if (widget.jobReal1Id.isNotEmpty) {
                  jobReal2CariBloc.add(RequestToUpdateJobReal2Event());
                }
                Navigator.pop(context);
              },
              child: const Icon(Icons.save, color: Colors.white, size: 28),
            ),
            body: JobReal2CariPage(
                custId: widget.custId, jobReal1Id: widget.jobReal1Id)));
  }
}

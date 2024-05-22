import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobReal2CariMainPage extends StatelessWidget {
  final String custId;
  final String custName;
  final String jobReal1Id;

  const JobReal2CariMainPage(
      {super.key,
      required this.custId,
      required this.jobReal1Id,
      required this.custName});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Daftar Polis $custName'),
            ),            
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
              tooltip: 'Save',
              onPressed: () {
                JobReal2CariBloc jobReal2CariBloc =
                    BlocProvider.of<JobReal2CariBloc>(context);
                jobReal2CariBloc.add(RequestToUpdateJobReal2Event());
              },
              child: const Icon(Icons.save, color: Colors.white, size: 28),
            ),
            body: JobReal2CariPage(
                custId: custId, jobReal1Id: jobReal1Id)));
  }

  
}

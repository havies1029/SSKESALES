import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobreal3cari_list.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobReal3CariMainPage extends StatelessWidget {
  final String jobReal1Id;

  const JobReal3CariMainPage({
    super.key,
    required this.jobReal1Id,
  });

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Daftar COB'),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
              tooltip: 'Save',
              onPressed: () {
                JobReal3CariBloc jobReal3CariBloc =
                    BlocProvider.of<JobReal3CariBloc>(context);
                if (jobReal1Id.isNotEmpty) {
                  jobReal3CariBloc.add(RequestToUpdateJobReal3Event());
                }
                Navigator.pop(context);
              },
              child: const Icon(Icons.save, color: Colors.white, size: 28),
            ),
            body: JobReal3CariPage(jobReal1Id: jobReal1Id)));
  }
}

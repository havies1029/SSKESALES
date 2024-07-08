import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcrud_form.dart';
import 'package:esalesapp/repositories/jobreal/jobrealcrud_repository.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobRealCrudMainPage extends StatelessWidget {
  final String viewMode;
  final String recordId;

  const JobRealCrudMainPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  Widget build(BuildContext context) {   

    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('${viewMode == "tambah"?"Tambah": viewMode == "ubah"?"Ubah":"Lihat"} Task'),
            ),
            //backgroundColor: Colors.grey[200],
            body: JobRealCrudFormPage(viewMode: viewMode, recordId: recordId)));
  }
}

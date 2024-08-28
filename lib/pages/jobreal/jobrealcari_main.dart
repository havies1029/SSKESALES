import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealbtnfilter_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealtab_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_tab.dart';
import 'package:esalesapp/repositories/jobreal/jobrealcrud_repository.dart';
import 'package:esalesapp/repositories/jobreal/jobrealfoto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobRealCariMainPage extends StatefulWidget {
  final bool readOnly;
  final String personId;
  const JobRealCariMainPage({super.key, required this.personId, required this.readOnly});

  @override
  State<JobRealCariMainPage> createState() => JobRealCariMainPageState();
}

class JobRealCariMainPageState extends State<JobRealCariMainPage>{

  @override
  Widget build(BuildContext context) {    
    return Scaffold(            
      body: JobRealCariTabPage(personId: widget.personId, readOnly: widget.readOnly),
    );
  }

}
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealtab_bloc.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_tab.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => JobRealTabBloc(),          
        ),
        BlocProvider(
          create: (context)=>JobRealGlobalCubit()
        )
      ],
      child: Scaffold(            
        body: JobRealCariTabPage(personId: widget.personId, readOnly: widget.readOnly),
      ),
    );
  }

}
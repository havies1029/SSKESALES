import 'package:esalesapp/pages/jobreal/jobrealcari_tab.dart';
import 'package:flutter/material.dart';

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
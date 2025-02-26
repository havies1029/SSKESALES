import 'package:esalesapp/blocs/mstproject/projectlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogStartProjectWidget extends StatefulWidget {
  final String projectId;

  const DialogStartProjectWidget({super.key, required this.projectId});

  @override
  DialogStartProjectWidgetState createState() =>
      DialogStartProjectWidgetState();
}

class DialogStartProjectWidgetState extends State<DialogStartProjectWidget> {
  late ProjectListBloc projectListBloc;

  @override
  Widget build(BuildContext context) {
    projectListBloc = BlocProvider.of<ProjectListBloc>(context);
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () {
        projectListBloc.add(StartProjectListEvent(projectId: widget.projectId));
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirmation !"),
      content: const Text("Apakah Anda yakin untuk memulai project ini?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return alert;
  }
}

import 'package:esalesapp/blocs/projecttree/prjtreelist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrjTreeDialogWidget extends StatefulWidget {
  final String projectId;

  const PrjTreeDialogWidget({super.key, required this.projectId});

  @override
  PrjTreeDialogWidgetState createState() =>
      PrjTreeDialogWidgetState();
}

class PrjTreeDialogWidgetState extends State<PrjTreeDialogWidget> {
  late PrjtreeListBloc prjTreeListBloc;

  @override
  Widget build(BuildContext context) {
    prjTreeListBloc = BlocProvider.of<PrjtreeListBloc>(context);
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () {
        prjTreeListBloc.add(StartPrjTreeListEvent(
            projectId: widget.projectId,
          ));        
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

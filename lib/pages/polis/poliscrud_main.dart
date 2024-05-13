import 'package:esalesapp/pages/polis/poliscrud_form.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

class PolisCrudMainPage extends StatelessWidget {
  final String viewMode;
  final String recordId;

  const PolisCrudMainPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  Widget build(BuildContext context) {   

    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Polis'),
            ),
            //backgroundColor: Colors.grey[200],
            body: PolisCrudFormPage(viewMode: viewMode, recordId: recordId)));
  }
}

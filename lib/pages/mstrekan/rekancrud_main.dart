import 'package:esalesapp/pages/mstrekan/rekancontactlist_main.dart';
import 'package:esalesapp/pages/mstrekan/rekancrud_form.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';

class RekanCrudMainPage extends StatelessWidget {
  final String rekanTypeId;
  final String viewMode;
  final String recordId;

  const RekanCrudMainPage(
      {super.key,
      required this.rekanTypeId,
      required this.viewMode,
      required this.recordId});

  @override
  Widget build(BuildContext context) {
    return MobileDesignWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            '${viewMode == "tambah" ? "Tambah" : viewMode == "ubah" ? "Ubah" : "Lihat"} Customer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 480,
              child: RekanCrudFormPage(
                  rekanTypeId: rekanTypeId, viewMode: viewMode, recordId: recordId),
            ),
            SizedBox(height: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey, thickness: 2,),
              ),
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('List Contact :',
                        style: MyText.titleMedium(context)!
                            .copyWith(color: Colors.cyan)),
             ),
            SizedBox(height: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey, thickness: 2,),
              ),
            ),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RekanContactListMainPage(mrekanId: recordId),
              ))
          ],
        ),
      ),
    ));
  }
}

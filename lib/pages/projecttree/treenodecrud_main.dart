import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/projecttree/treenodecrud_form.dart';

class TreenodeCrudMainPage extends StatelessWidget {
	final String prjtree1Id;
	final String viewMode;
	final String recordId;
	const TreenodeCrudMainPage({super.key, required this.prjtree1Id, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Project'),
				),
				body: TreenodeCrudFormPage(prjtree1Id: prjtree1Id, viewMode: viewMode, recordId: recordId)));
	}
}

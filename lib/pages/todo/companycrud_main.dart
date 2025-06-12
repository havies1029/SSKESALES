import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/todo/companycrud_form.dart';

class CompanyCrudMainPage extends StatelessWidget {
	final String timeline1Id;
	final String viewMode;
	final String recordId;
	const CompanyCrudMainPage({super.key, required this.timeline1Id, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} To Do'),
				),
				body: CompanyCrudFormPage(timeline1Id: timeline1Id, viewMode: viewMode, recordId: recordId)));
	}
}

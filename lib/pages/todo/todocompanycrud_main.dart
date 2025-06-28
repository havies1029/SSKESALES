import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/todo/todocompanycrud_form.dart';

class TodoCompanyCrudMainPage extends StatelessWidget {
	final String timeline1Id;
	final String viewMode;
	final String recordId;
	const TodoCompanyCrudMainPage({super.key, required this.timeline1Id, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Planning'),
				),
				body: TodoCompanyCrudFormPage(timeline1Id: timeline1Id, viewMode: viewMode, recordId: recordId)));
	}
}

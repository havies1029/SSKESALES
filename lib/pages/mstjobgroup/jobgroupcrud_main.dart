import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/mstjobgroup/jobgroupcrud_form.dart';

class JobGroupCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const JobGroupCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Job Function'),
				),
				body: JobGroupCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}

import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/mstjob/jobcrud_form.dart';
import 'package:flutter/material.dart';

class JobCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const JobCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Task'),
				),
				body: JobCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}

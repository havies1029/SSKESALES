import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/mstjobcat/jobcatcrud_form.dart';

class JobCatCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const JobCatCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Job Category'),
				),
				body: JobCatCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}

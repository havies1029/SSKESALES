import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/mstproject/projectcrud_form.dart';

class ProjectCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const ProjectCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Master Project'),
				),
				body: ProjectCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}

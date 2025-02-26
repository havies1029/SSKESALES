import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/projectplan/plancrud_form.dart';

class PlanCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const PlanCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Running Project'),
				),
				body: PlanCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}

import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/pages/projecttree/prjtreecrud_form.dart';

class PrjtreeCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const PrjtreeCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Project Tree'),
				),
				body: PrjtreeCrudFormPage(viewMode: viewMode, recordId: recordId)));
	}
}

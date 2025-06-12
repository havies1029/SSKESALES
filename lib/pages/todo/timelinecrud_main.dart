import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:esalesapp/pages/todo/timelinecrud_form.dart';
import 'package:esalesapp/pages/todo/companylist_main.dart';

class TimelineCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const TimelineCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} To Do'),
				),
				body: SingleChildScrollView(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							SizedBox(
								height: 400,
								child: TimelineCrudFormPage(viewMode: viewMode, recordId: recordId),
							),
							SizedBox(height: 10,
								child: Padding(
									padding: const EdgeInsets.all(8.0),
									child: Divider(color: Colors.grey, thickness: 2,),
								),
							),
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: Text('To Do List :',
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
									child: CompanyListMainPage(timeline1Id: recordId),
								)
							),
						],
					),
				),
			));
	}
}

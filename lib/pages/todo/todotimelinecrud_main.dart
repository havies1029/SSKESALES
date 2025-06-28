import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/mobiledesign_widget.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:esalesapp/pages/todo/todotimelinecrud_form.dart';
import 'package:esalesapp/pages/todo/todocompanylist_main.dart';

class TodoTimelineCrudMainPage extends StatelessWidget {
	final String viewMode;
	final String recordId;
	const TodoTimelineCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
	Widget build(BuildContext context) {
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Planning'),
				),
				body: SingleChildScrollView(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							SizedBox(
								height: 450,
								child: TodoTimelineCrudFormPage(viewMode: viewMode, recordId: recordId),
							),
							SizedBox(height: 10,
								child: Padding(
									padding: const EdgeInsets.all(8.0),
									child: Divider(color: Colors.grey, thickness: 2,),
								),
							),
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: Text('Daftar Perusahaan :',
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
									child: TodoCompanyListMainPage(timeline1Id: recordId),
								)
							),
            

						],
					),
				),
			));
	}
}

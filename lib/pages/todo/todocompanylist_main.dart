import 'package:flutter/material.dart';
import 'package:esalesapp/pages/todo/todocompanylist_list.dart';

class TodoCompanyListMainPage extends StatelessWidget {
	final String timeline1Id;
	const TodoCompanyListMainPage({super.key, required this.timeline1Id});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: TodoCompanyListPage(timeline1Id: timeline1Id),
		);
	}
}

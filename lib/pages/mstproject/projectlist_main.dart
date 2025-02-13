import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstproject/projectlist_list.dart';

class ProjectListMainPage extends StatelessWidget {
	const ProjectListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const ProjectListPage(),
		);
	}
}

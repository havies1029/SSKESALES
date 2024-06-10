import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstjobgroup/jobgroupcari_list.dart';

class JobGroupCariMainPage extends StatelessWidget {
	const JobGroupCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const JobGroupCariPage(),
		);
	}
}

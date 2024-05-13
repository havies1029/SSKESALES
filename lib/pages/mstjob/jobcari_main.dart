import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstjob/jobcari_list.dart';

class JobCariMainPage extends StatelessWidget {
	const JobCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const JobCariPage(),
		);
	}
}

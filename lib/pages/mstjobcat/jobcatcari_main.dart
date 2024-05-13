import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstjobcat/jobcatcari_list.dart';

class JobCatCariMainPage extends StatelessWidget {
	const JobCatCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const JobCatCariPage(),
		);
	}
}

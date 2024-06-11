import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstjob/jobcari_list.dart';

class JobCariMainPage extends StatelessWidget {
  final String personId;
  final String personName;
	const JobCariMainPage({super.key,
      required this.personId,
      required this.personName});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: JobCariPage(personId: personId),
		);
	}
}

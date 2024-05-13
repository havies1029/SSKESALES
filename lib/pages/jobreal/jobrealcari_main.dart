import 'package:flutter/material.dart';
import 'package:esalesapp/pages/jobreal/jobrealcari_list.dart';

class JobRealCariMainPage extends StatelessWidget {
	const JobRealCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const JobRealCariPage(),
		);
	}
}

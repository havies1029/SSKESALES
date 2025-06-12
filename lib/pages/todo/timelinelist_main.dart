import 'package:flutter/material.dart';
import 'package:esalesapp/pages/todo/timelinelist_list.dart';

class TimelineListMainPage extends StatelessWidget {
	const TimelineListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const TimelineListPage(),
		);
	}
}

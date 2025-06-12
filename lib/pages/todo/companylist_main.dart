import 'package:flutter/material.dart';
import 'package:esalesapp/pages/todo/companylist_list.dart';

class CompanyListMainPage extends StatelessWidget {
	final String timeline1Id;
	const CompanyListMainPage({super.key, required this.timeline1Id});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: CompanyListPage(timeline1Id: timeline1Id),
		);
	}
}

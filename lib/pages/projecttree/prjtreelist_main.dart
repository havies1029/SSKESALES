import 'package:flutter/material.dart';
import 'package:esalesapp/pages/projecttree/prjtreelist_list.dart';

class PrjtreeListMainPage extends StatelessWidget {
	const PrjtreeListMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const PrjtreeListPage(),
		);
	}
}

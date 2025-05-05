import 'package:flutter/material.dart';
import 'package:esalesapp/pages/projecttree/treenodelist_list.dart';

class TreenodeListMainPage extends StatelessWidget {
	final String prjtree1Id;
	const TreenodeListMainPage({super.key, required this.prjtree1Id});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: TreenodeListPage(prjtree1Id: prjtree1Id),
		);
	}
}

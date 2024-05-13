import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstcob/cobcari_list.dart';

class CobCariMainPage extends StatelessWidget {
	const CobCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const CobCariPage(),
		);
	}
}

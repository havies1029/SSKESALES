import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstcustcat/custcatcari_list.dart';

class CustCatCariMainPage extends StatelessWidget {
	const CustCatCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const CustCatCariPage(),
		);
	}
}

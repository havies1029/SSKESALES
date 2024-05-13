import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mststaff/staffcari_list.dart';

class StaffCariMainPage extends StatelessWidget {
	const StaffCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const StaffCariPage(),
		);
	}
}

import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstjabatan/jabatancari_list.dart';

class JabatanCariMainPage extends StatelessWidget {
	const JabatanCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const JabatanCariPage(),
		);
	}
}

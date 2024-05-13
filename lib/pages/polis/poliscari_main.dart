import 'package:flutter/material.dart';
import 'package:esalesapp/pages/polis/poliscari_list.dart';

class PolisCariMainPage extends StatelessWidget {
	const PolisCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const PolisCariPage(),
		);
	}
}

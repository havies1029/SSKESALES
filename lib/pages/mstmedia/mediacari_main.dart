import 'package:flutter/material.dart';
import 'package:esalesapp/pages/mstmedia/mediacari_list.dart';

class MediaCariMainPage extends StatelessWidget {
	const MediaCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const MediaCariPage(),
		);
	}
}

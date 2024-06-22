import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/timeline/expiredbysales_bloc.dart';
import 'package:esalesapp/pages/timeline/expiredbysales_list_widget.dart';

class ExpiredBySalesPage extends StatefulWidget {
  final int severity;
	final String expgroupId;
	final String groupNama;
	const ExpiredBySalesPage({super.key, 
    required this.expgroupId, required this.severity, required this.groupNama});

	@override
	ExpiredBySalesPageState createState() => ExpiredBySalesPageState();
}

class ExpiredBySalesPageState extends State<ExpiredBySalesPage> {
	late ExpiredBySalesBloc expiredBySalesBloc;
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		expiredBySalesBloc = BlocProvider.of<ExpiredBySalesBloc>(context);
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: [
					buildList()
				],

			),
		);
	}
	void refreshData() {
		expiredBySalesBloc.add(
			RefreshExpiredBySalesEvent(expgroupId: widget.expgroupId));
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[ExpiredBySalesListWidget(
          severity: widget.severity,
          expgroupId: widget.expgroupId,
          groupNama: widget.groupNama,)],
		));
	}

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/assignment/clientassigncari_bloc.dart';
import 'package:esalesapp/pages/assignment/clientassigncari_tile_widget.dart';
import 'package:esalesapp/models/assignment/clientassigncari_model.dart';

import '../../common/constants.dart';

class ClientAssignCariListWidget extends StatefulWidget {
	final String searchText;
	const ClientAssignCariListWidget({super.key, required this.searchText});

	@override
	ClientAssignCariListWidgetState createState() => ClientAssignCariListWidgetState();
}

class ClientAssignCariListWidgetState extends State<ClientAssignCariListWidget> {
	late ClientAssignCariBloc clientAssignCariBloc;
	List<ClientAssignCariModel> clientAssignCari = [];
	final ScrollController _scrollController = ScrollController();

	@override
	void initState() {
		super.initState();
		_scrollController.addListener(_onScroll);
	}

	@override
	void dispose() {
		_scrollController
			..removeListener(_onScroll)
			..dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		clientAssignCariBloc = BlocProvider.of<ClientAssignCariBloc>(context);
		return BlocConsumer<ClientAssignCariBloc, ClientAssignCariState>(
			builder: (context, state) {
		if (state.status == ListStatus.success) {
			if (!state.hasReachedMax) {
				clientAssignCari.addAll(state.items);
			}

		return state.items.isNotEmpty
			? Flexible(
				child: ListView.builder(
					padding: EdgeInsets.zero,
					controller: _scrollController,
					itemCount: state.items.length,
					itemBuilder: (_, index) => Container(
						margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
						padding: const EdgeInsets.all(0.2),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(15.0)),
						child: Column(
							children: <Widget>[
								ClientAssignCariTileWidget(
									clientId: state.items[index].clientId,
									clientNama: state.items[index].clientNama,
									marketingId: state.items[index].marketingId,
								)
							],
						),
					)),
				)
			: const Center(
				child: Padding(
					padding: EdgeInsets.only(top: 80.0),
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				),
			);
		} else {
			return const Center(
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				);
			}
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			clientAssignCariBloc.add(FetchClientAssignCariEvent(
				));
		}
	}

}

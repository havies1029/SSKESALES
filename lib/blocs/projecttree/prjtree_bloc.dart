import 'dart:convert';

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:equatable/equatable.dart';
import 'package:esalesapp/models/projecttree/prjtreenode_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'prjtree_event.dart';
part 'prjtree_state.dart';

class PrjTreeBloc extends Bloc<PrjTreeEvent, PrjTreeState> {
  PrjTreeBloc() : super(TreeInitial()) {
    on<FetchTreeData>(_onFetch);
  }

  Future<void> _onFetch(FetchTreeData event, Emitter<PrjTreeState> emit) async {
    emit(TreeLoading());
    try {
      // Simulasi data lokal sebagai pengganti http.get
      const dataString = '''{
        "id": "001",
        "title": "Root",
        "desc": "Root folder",
        "nodeType": "folder",
        "children": [
          {
            "id": "002",
            "title": "Folder A",
            "desc": "-",
            "nodeType": "folder",
            "children": [
              {
                "id": "003",
                "title": "File A1",
                "desc": "-",
                "nodeType": "file"
              },
              {
                "id": "004",
                "title": "Action A2",
                "desc": "-",
                "nodeType": "action"
              }
            ]
          },
          {
            "id": "005",
            "title": "File B",
            "desc": "-",
            "nodeType": "file"
          }
        ]
      }''';

      final jsonData = jsonDecode(dataString);
      final rootData = PrjTreeNodeModel.fromJson(jsonData);
      final tree = _buildNode(rootData);
      emit(TreeLoaded(tree));
    } catch (e) {
      emit(TreeError(e.toString()));
    }
  }

  TreeNode<PrjTreeNodeModel> _buildNode(PrjTreeNodeModel data) {
    final node = TreeNode(data: data);
    for (var child in data.children) {
      node.add(_buildNode(child));
    }
    return node;
  }

}
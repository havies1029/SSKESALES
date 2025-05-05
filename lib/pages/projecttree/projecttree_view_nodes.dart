import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:esalesapp/models/projecttree/prjtreenode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomTreeView extends StatelessWidget {
  final TreeNode<PrjTreeNodeModel> rootNode;
  const CustomTreeView({super.key, required this.rootNode});

  @override
  Widget build(BuildContext context) {
    return TreeView.simple(
      tree: rootNode,
      expansionIndicatorBuilder: (context, node) =>
            ChevronIndicator.rightDown(
          tree: node,
          color: Colors.blue[700],
          padding: const EdgeInsets.all(8),
        ),
      builder: (context, node) {
        final data = node.data!;
        switch (data.nodeType) {
          case "folder" :
            return _buildSlidableNode(data, Icons.folder, Colors.orange);
          case "file":
            return _buildSlidableNode(data, Icons.insert_drive_file, Colors.grey);
          case "action":
            return _buildActionNode(context, data);  
          default: 
            return _buildSlidableNode(data, Icons.help, Colors.red);        
        }
      },
    );


  }

  Widget _buildSlidableNode(PrjTreeNodeModel data, IconData icon, Color color) {
    return Slidable(
      key: ValueKey(data.title),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => debugPrint('Edit ${data.title}'),
            icon: Icons.edit,
            label: 'Edit',
            backgroundColor: Colors.blue,
          ),
          SlidableAction(
            onPressed: (_) => debugPrint('Delete ${data.title}'),
            icon: Icons.delete,
            label: 'Hapus',
            backgroundColor: Colors.red,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(data.title),
      ),
    );
  }

  Widget _buildActionNode(BuildContext context, PrjTreeNodeModel data) {
    return ListTile(
      leading: Icon(Icons.settings, color: Colors.blue),
      title: Text(data.title),
      trailing: IconButton(
        icon: Icon(Icons.info_outline),
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Aksi pada ${data.title}')),
        ),
      ),
    );
  }
}

import 'package:esalesapp/blocs/projecttree/prjtree_bloc.dart';
import 'package:esalesapp/pages/projecttree/projecttree_view_nodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreeViewPage extends StatelessWidget {
  const TreeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TreeView with API & Bloc')),      
      body: BlocConsumer<PrjTreeBloc, PrjTreeState>(
        builder: (context, state) {
          if (state is TreeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TreeLoaded) {
            return CustomTreeView(rootNode: state.rootNode);
          } else if (state is TreeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Tekan tombol untuk load data'));
        }, listener: (BuildContext context, PrjTreeState state) { 
          if (state is TreeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          else if (state is TreeLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data loaded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } 
          else if (state is TreeLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Loading data...'),
                backgroundColor: Colors.blue,
              ),
            );
          }
        },
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PrjTreeBloc>().add(FetchTreeData()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
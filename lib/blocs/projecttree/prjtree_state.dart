part of 'prjtree_bloc.dart';

abstract class PrjTreeState {}

class TreeInitial extends PrjTreeState {}
class TreeLoading extends PrjTreeState {}
class TreeLoaded extends PrjTreeState {
  final TreeNode<PrjTreeNodeModel> rootNode;
  TreeLoaded(this.rootNode);
}
class TreeError extends PrjTreeState {
  final String message;
  TreeError(this.message);
}
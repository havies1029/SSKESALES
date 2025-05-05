enum PrjNodeType { folder, file, action }

class PrjTreeNodeModel {
  final String id;
  final String title;
  final String desc;
  final String nodeType;
  final List<PrjTreeNodeModel> children;

  PrjTreeNodeModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.nodeType,
    this.children = const [],
  });

  PrjTreeNodeModel copyWith({
    String? id,
    String? title,
    String? desc,
    String? nodeType,
    String? parentId,
    List<PrjTreeNodeModel>? children,
  }) {
    return PrjTreeNodeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      nodeType: nodeType ?? this.nodeType,
      children: children ?? this.children, 
    );
  }

  factory PrjTreeNodeModel.fromJson(Map<String, dynamic> json) {
    return PrjTreeNodeModel(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      nodeType: json['nodeType'],
      children: (json['children'] as List<dynamic>?)
              ?.map((child) => PrjTreeNodeModel.fromJson(child))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'nodeType': nodeType.toString(),
      'children': children.map((child) => child.toJson()).toList(),
    };
  }
}
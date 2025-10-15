class CheckListItem {
  final String title;
  final String description;
  bool isDone;

  CheckListItem({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  // Convert to map for Hive storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  // Convert back from map
  factory CheckListItem.fromMap(Map<String, dynamic> map) {
    return CheckListItem(
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
    );
  }
}

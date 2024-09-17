class Todo {
  int? id;
  String title;
  String description;
  bool isFavorite;

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}

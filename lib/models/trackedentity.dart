
import 'package:git_todo/models/todoentity.dart';

class TrackedEntity {
  String url;
  List<TodoEntity> todoList;

  TrackedEntity.fromJson(Map<String, dynamic> json) {
    this.url = json['url'];
    for(Map<String, dynamic> todo in json['todolist']) {
      todoList.add(TodoEntity.fromJson(todo));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'url': this.url,
      'todolist': this.todoList
    };
  }

  void update() {
    
  }
}

import 'package:git_todo/models/todoentity.dart';
import 'package:github/server.dart';

import 'package:git_todo/utils/githubutil.dart';

class TrackedEntity {
  String urlSlug;
  String path;
  List<TodoEntity> todoList = [];

  TrackedEntity.fromJson(Map<String, dynamic> json) {
    this.urlSlug = json['urlslug'];
    this.path = json['path'];
    for(Map<String, dynamic> todo in json['todolist']) {
      this.todoList.add(TodoEntity.fromJson(todo));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'urlslug': this.urlSlug,
      'path': this.path,
      'todolist': todoList.map(
        (TodoEntity ent) => ent.toJson()
      ).toList()
    };
  }

  TrackedEntity(String urlSlug, String path) {
    this.urlSlug = urlSlug;
    this.path = path;
  }

  Future<void> update(GitHub github) async {
    //fetch all todos from the url resource and repopulate todoList
    todoList = await GithubUtil.getTodoEntities(github, this.urlSlug, this.path);
  }
}
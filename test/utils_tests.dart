import 'package:flutter_test/flutter_test.dart';
import 'package:git_todo/models/todoentity.dart';
import 'package:git_todo/singletons/ghsingleton.dart';
import 'package:github/server.dart';
import 'package:git_todo/utils/githubutil.dart';

void main() {

  test("Utils", () async {
    GitHub github = GHSingleton().github;
    List<TodoEntity> todos = await GithubUtil.getTodoEntities(github, "karanpanjabi/GitTodoTest", "/todofile.py");
    print(todos.toString());
  });
}
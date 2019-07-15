import 'package:git_todo/models/todoentity.dart';
import 'package:github/server.dart';

class GithubUtil {
  static Future<List<TodoEntity>> getTodoEntities(GitHub github, String slugUrl, String path) async {
    RepositorySlug slug = RepositorySlug.full(slugUrl);
    RepositoryContents rc = await github.repositories.getContents(slug, path);
    List<TodoEntity> todos = await traverseSearch(github, slug, rc.tree);
    return todos;
  }

  static Future<List<TodoEntity>> traverseSearch(GitHub github, RepositorySlug slug, List<GitHubFile> tree) async {
    List<Future> flist = [];
    for(GitHubFile file in tree) {
      Future t;
      if(file.type == "file") {
        t = traverseSearchFile(github, slug, file);
      }
      else if(file.type == "dir") {
        RepositoryContents rc = await github.repositories.getContents(slug, file.path);
        t = traverseSearch(github, slug, rc.tree);
      }
      flist.add(t);
    }
    var allEntities = await Future.wait(flist);

    List<TodoEntity> finalList = [];
    //extract and extend to final list
    for(var entList in allEntities) {
      if(entList != null) {
        finalList.addAll(entList);
      }
    }

    return finalList.length > 0 ? finalList : null;
  }

  //could be a bunch of todos in a file
  static Future<List<TodoEntity>> traverseSearchFile(GitHub github, RepositorySlug slug, GitHubFile file) async {
    if(file == null) return null;
    if(file.type == "file") {
      print(file.path);
      try {
        RepositoryContents contents = await github.repositories.getContents(slug, file.path);
        return getTodos(contents.file.text, file.path);
      }
      catch(err) {
        print(err.toString());
      }
    }
    return null;
  }

  static List<TodoEntity> getTodos(String content, String filepath) {
    List<TodoEntity> tempList = [];
    RegExp regExp = new RegExp(
      r"@ *TODO",
      caseSensitive: false,
      multiLine: false
    );
    
    List<String> lines = content.split("\n");
    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      RegExpMatch match = regExp.firstMatch(line);
      if(match != null) {
        tempList.add(
          TodoEntity(filepath, i+1, line.substring(match.end+1))
        );
      }
    }

    return (tempList.length > 0) ? tempList : null;
  }
}
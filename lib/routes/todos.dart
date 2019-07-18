import 'package:flutter/material.dart';
import 'package:git_todo/models/trackedentity.dart';
import 'package:git_todo/navdrawer.dart';
import 'package:git_todo/routes/repos.dart';
import 'package:git_todo/singletons/ghsingleton.dart';
import 'package:git_todo/singletons/trackedentities.dart';
import 'package:github/server.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TrackedEntities _entities = TrackedEntities();
  GitHub _github;

  @override
  void initState() {
    super.initState();

    _github = GHSingleton().github;
  }

  Future<void> _onRefresh() async {
    await _entities.update(_github);

    setState(() {});

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      drawer: NavDrawer.getDrawer(context),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.separated(
          separatorBuilder: (context, i) => new Divider(),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _entities.tList.length,
          itemBuilder: (BuildContext context, int index) {
            return TodoListItem(_entities.tList[index]);
          },
        ),
      ),
    );
  }
}

class TodoListItem extends StatefulWidget {
  TrackedEntity entity;

  TodoListItem(this.entity, {Key key}) : super(key: key);

  @override
  _TodoListItem createState() => _TodoListItem();
}

class _TodoListItem extends State<TodoListItem> {

  TrackedEntity _entity;

  @override
  void initState() {
    super.initState();

    _entity = this.widget.entity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title:
            Text("${_entity.urlSlug} : ${_entity.path}"),
        subtitle: ListView.builder(
          shrinkWrap: true,
          itemCount: _entity.todoList.length,
          itemBuilder: (BuildContext context, int i) {
            return Text("$i) ${_entity.todoList[i].info} at ${_entity.todoList[i].filepath} on line ${_entity.todoList[i].linenum}");
          },
        ),

      ),
    );
  }
}

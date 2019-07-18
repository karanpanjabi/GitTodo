import 'package:flutter/material.dart';
import 'package:git_todo/models/trackedentity.dart';
import 'package:git_todo/navdrawer.dart';
import 'package:git_todo/routes/todos.dart';
import 'package:git_todo/singletons/ghsingleton.dart';
import 'package:git_todo/singletons/trackedentities.dart';
import 'package:github/server.dart';

class ReposScreen extends StatefulWidget {
  ReposScreen({Key key}) : super(key: key);

  @override
  _ReposScreenState createState() => _ReposScreenState();
}

class _ReposScreenState extends State<ReposScreen> {
  List<Repository> repos = [];
  GitHub github;

  @override
  void initState() {
    super.initState();
    github = GHSingleton().github;
    getRepositories();
  }

  Future<void> getRepositories() async {
    Stream<Repository> reps = github.repositories
        .listRepositories(sort: "updated", direction: "desc");

    await for (Repository rep in reps) {
      setState(() {
        repos.add(rep);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Repositories"),
        ),
        drawer: NavDrawer.getDrawer(context),
        body: ListView.separated(
          itemCount: repos.length,
          itemBuilder: (BuildContext context, int i) {
            return RepoListItemWidget(repos[i]);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}

class RepoListItemWidget extends StatefulWidget {
  Repository repo;
  RepoListItemWidget(Repository repo, {Key key}) : super(key: key) {
    this.repo = repo;
  }

  _RepoListItemState createState() => _RepoListItemState();
}

class _RepoListItemState extends State<RepoListItemWidget> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();

    //check if the current repo is a tracked entity
    isSelected =
        TrackedEntities().isBeingTracked(this.widget.repo.slug().fullName);
    print(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        child: ListTile(
          title: Text(this.widget.repo.name),
          trailing: Checkbox(
            value: isSelected,
            // tristate: true,
            onChanged: (bool value) {
              setState(() {
                isSelected = value;
              });

              if (value) {
                //add trackingentity for the repo
                TrackedEntities().addEntity(
                    TrackedEntity(this.widget.repo.slug().fullName, "/"));
                print("Creating entity for ${this.widget.repo.name}");
              } else {
                //remove trackingentity for the repo
                TrackedEntities().removeEntity(
                    TrackedEntity(this.widget.repo.slug().fullName, "/"));
                print("Removing entity ${this.widget.repo.name}");
              }
            },
          ),
        ),
      ),
    );
  }
}

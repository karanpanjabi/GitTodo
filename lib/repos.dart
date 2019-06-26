import 'package:flutter/material.dart';
import 'package:git_todo/ghsingleton.dart';
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
    Stream<Repository> reps = github.repositories.listRepositories();

    await for(Repository rep in reps) {
      setState(() {
       repos.add(rep); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account page"),
      ),
      body: ListView.builder(
        itemCount: repos.length,
        itemBuilder: (BuildContext context, int i) {
          return Text(repos[i].fullName);
        },
      )
    );
  }

}
import 'dart:convert';
import 'dart:io';

import 'package:git_todo/models/trackedentity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'package:github/server.dart';

class TrackedEntities {
  static final TrackedEntities _singleton = TrackedEntities._internal();
  List<TrackedEntity> t_list;
  Database _db;

  factory TrackedEntities() {
    return _singleton;
  }

  TrackedEntities._internal() {
    t_list = [];
  }

  Map<String, dynamic> toJson() {
    return {
      'userdata': t_list.map(
        (TrackedEntity ent) => ent.toJson()
      ).toList()
    };
  }

  initEntities() async {
    //read from file
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = '${dir.path}/userdb.db';
    _db = await createDatabaseFactoryIo().openDatabase(dbPath);

    List<dynamic> dbData = jsonDecode(await _db.get("userdata"));
    for (var item in dbData) {
      t_list.add(TrackedEntity.fromJson(item));
    }
  }

  addEntity(TrackedEntity ent) {
    t_list.add(ent);
    updateDB();
  }

  //go through every entity in the list and update them
  Future<void> update(GitHub github) async {
    var futlist = <Future>[];
    for (TrackedEntity ent in t_list) {
      futlist.add(ent.update(github));
    }
    await Future.wait(futlist);
    
    //not sure if i should update here
    await updateDB();
  }

  Future<void> updateDB() async {
    await _db.put('userdata', this.toJson());
  }
}
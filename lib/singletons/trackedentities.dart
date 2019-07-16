import 'dart:convert';
import 'dart:io';

import 'package:git_todo/models/trackedentity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'package:github/server.dart';

class TrackedEntities {
  static final TrackedEntities _singleton = TrackedEntities._internal();
  List<TrackedEntity> tList;
  Database _db;

  factory TrackedEntities() {
    return _singleton;
  }

  TrackedEntities._internal() {
    tList = [];
  }

  Map<String, dynamic> toJson() {
    return {
      'userdata': tList.map(
        (TrackedEntity ent) => ent.toJson()
      ).toList()
    };
  }

  initEntities() async {
    //read from file
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = '${dir.path}/userdb.db';
    _db = await createDatabaseFactoryIo().openDatabase(dbPath);
    var jsondata = await _db.get("userdata");
    if(jsondata == null) return;
    print(jsondata);
    jsondata = jsondata['userdata'];

    // List<dynamic> dbData = jsonDecode(jsondata);
    for (var item in jsondata) {
      tList.add(TrackedEntity.fromJson(item));
    }
  }

  addEntity(TrackedEntity ent) {
    tList.add(ent);
    updateDB();
  }

  removeEntity(TrackedEntity ent) {
    tList.removeWhere((TrackedEntity inList) {
      return inList.urlSlug == ent.urlSlug && inList.path == ent.path;
    });
    updateDB();
  }

  //go through every entity in the list and update them
  Future<void> update(GitHub github) async {
    var futlist = <Future>[];
    for (TrackedEntity ent in tList) {
      futlist.add(ent.update(github));
    }
    await Future.wait(futlist);
    
    //not sure if i should update here
    await updateDB();
  }

  Future<void> updateDB() async {
    var key = await _db.put(this.toJson(), 'userdata');
  }

  bool isBeingTracked(String repo) {
    for(TrackedEntity ent in tList) {
      if(ent.urlSlug == repo) {
        return true;
      }
    }
    return false;
  }
}
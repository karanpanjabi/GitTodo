import 'package:git_todo/models/trackedentity.dart';

class TrackedEntities {
  static final TrackedEntities _singleton = TrackedEntities._internal();
  List<TrackedEntity> t_list;

  factory TrackedEntities() {
    return _singleton;
  }

  TrackedEntities._internal() {
    //initialise t_list by fetching from file and then update
    
    //or if not found in file then fetch from github and store in file
  }

  void update() {

  }
}
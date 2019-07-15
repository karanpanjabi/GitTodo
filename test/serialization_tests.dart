import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:git_todo/models/trackedentity.dart';

void main() {
  test("test", () {
    String jsonStr = """
    {
    "url": "ABC",
    "todolist": [
        {
            "filename": "abc.dart",
            "linenum": 10,
            "info": "bleh"
        },
        {
            "filename": "abdc.dart",
            "linenum": 120,
            "info": "bl2eh"
        }
       ]
    }
    """;
    TrackedEntity ent = TrackedEntity.fromJson(jsonDecode(jsonStr));
    print(ent.toJson());
  });
}
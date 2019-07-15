import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Regex", () {
    RegExp regExp = new RegExp(
      r"@ *TODO",
      caseSensitive: false,
      multiLine: false
    );

    String codestr = "\nvoid main() {\n@TODO implement this\n}";

    RegExpMatch match = regExp.firstMatch(codestr);
    print(match.toString());
  });
}
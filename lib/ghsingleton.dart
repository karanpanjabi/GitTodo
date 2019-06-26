import 'package:github/server.dart';

class GHSingleton {
  static final GHSingleton _singleton = new GHSingleton._internal();
  GitHub github;

  factory GHSingleton() {
    return _singleton;
  }

  GHSingleton._internal() {
    github = createGitHubClient(auth: Authentication.withToken("--YOUR TOKEN HERE--"));
  }
}
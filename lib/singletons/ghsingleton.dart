import 'package:github/server.dart';

class GHSingleton {
  static final GHSingleton _singleton = new GHSingleton._internal();
  GitHub github;

  factory GHSingleton() {
    return _singleton;
  }

  GHSingleton._internal() {
    github = createGitHubClient(auth: Authentication.withToken("3a64ce7364037911de1e52f4f9b584c6c48e6100"));
  }
}
import 'package:flutter/material.dart';

class NavDrawer {
  static Drawer getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/todos');
            },
            title: Text("TODOs"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/account');
            },
            title: Text("Repositories"),
          ),
        ],
      ),
    );
  }
}

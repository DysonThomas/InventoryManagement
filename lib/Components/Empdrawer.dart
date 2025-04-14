import 'package:flutter/material.dart';
import 'package:inventorymanagement/manageUsers.dart';

import '../addUsers.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 80, // Adjust height as needed
            color: Colors.teal[700],
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(16),
            child: Text(
              "Master Liqudation",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_circle_rounded),
            title: Text("Add Employee"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => addUsers()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Manage Employee"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ManageEmployee()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}


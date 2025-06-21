import 'package:flutter/material.dart';
import 'package:sewoapp/config/config_global.dart';
import 'package:sewoapp/data_admin/data_admin_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(ConfigGlobal.namaAplikasi),
            accountEmail: const Text("john.doe@example.com"),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(110),
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            /* otherAccountsPictures: <Widget>[ */
            /*   ClipRRect( */
            /*     borderRadius: BorderRadius.circular(110), */
            /*     child: Image.asset( */
            /*       "images/user2.jpg", */
            /*       fit: BoxFit.cover, */
            /*     ), */
            /*   ), */
            /*   ClipRRect( */
            /*     borderRadius: BorderRadius.circular(110), */
            /*     child: Image.asset( */
            /*       "images/user3.jpg", */
            /*       fit: BoxFit.cover, */
            /*     ), */
            /*   ) */
            /* ], */
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text("Data Admin"),
            onTap: () {
              // Navigator.pushNamed(context, DataAdminScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

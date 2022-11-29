import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 86, 133, 94),
            ),
            child: Text('User Email, Photo, Wyloguj'),
          ),
          ListTile(
            title: const Text('Location'),
            leading: const Icon(Icons.location_pin),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Language'),
            leading: const Icon(Icons.language_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Change Password'),
            leading: const Icon(Icons.password_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Delete all data / Reset App'),
            leading: const Icon(Icons.delete_forever),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privace Policy'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {},
          ),
          ListTile(
            title: const Text('App Version'),
            leading: const Icon(Icons.info_outline_rounded),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

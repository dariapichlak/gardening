import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(),
      providerConfigs: const [
        EmailProviderConfiguration(),
      ],
      avatarSize: 100,
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/');
        }),
      ],
      children: [
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
    );
  }
}

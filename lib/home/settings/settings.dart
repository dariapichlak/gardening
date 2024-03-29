import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/settings/cubit/settings_cubit.dart';
import 'package:gardening/repositories/all_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(AllRepository())..start(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 242, 242, 242),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 172, 172, 172),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: IconButton(
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Color.fromARGB(255, 172, 172, 172),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0))),
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 242, 242, 242),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, bottom: 20, left: 25),
                        child: Text(
                          'Settings',
                          style: GoogleFonts.antic(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 15, offset: Offset(0, 10)),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 30),
                        child: ListView(
                          children: [
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
                              onTap: () {
                                context.read<SettingsCubit>().remove();

                                Navigator.of(context).pop();
                              },
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

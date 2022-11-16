import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/app_style/app_style.dart';
import 'package:gardening/home/notes_page/add_notes_page/add_notes_page.dart';
import 'package:gardening/home/notes_page/cubit/notes_page_cubit.dart';

class NotesPageContent extends StatefulWidget {
  const NotesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesPageContent> createState() => _NotesPageContentState();
}

class _NotesPageContentState extends State<NotesPageContent> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NotesPageCubit()..start(),
        child: BlocBuilder<NotesPageCubit, NotesPageState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return const Center(child: Text('Error'));
            }
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            if (state.documents.isNotEmpty) {
              final documents = state.documents;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    for (final document in documents) ...[
                      Dismissible(
                        background: const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 325.0),
                            child: Icon(Icons.delete),
                          ),
                        ),
                        key: ValueKey(document.id),
                        confirmDismiss: (direction) async {
                          return direction == DismissDirection.endToStart;
                        },
                        onDismissed: (_) {
                          FirebaseFirestore.instance
                              .collection('notes')
                              .doc(document.id)
                              .delete();
                        },
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: 350,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue,
                            ),
                            child: Builder(builder: (context) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(
                                    document['titleNote'],
                                  ),
                                  value: document['value'],
                                  onChanged: (bool? value) {
                                    FirebaseFirestore.instance
                                        .collection('notes')
                                        .doc(document.id)
                                        .update(
                                      {'value': value!},
                                    );
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }
            return const Center(child: Text('List is Empty'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.create),
        label: const Text('Add Note'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddNotesPage()));
        },
      ),
    );
  }
}

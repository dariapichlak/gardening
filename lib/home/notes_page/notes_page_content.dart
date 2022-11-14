import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/home/notes_page/add_notes_page/add_notes_page.dart';

class NotesPageContent extends StatelessWidget {
  const NotesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('notes').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Loading'));
            }
            final documents = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: ListView(
                children: [
                  for (final document in documents) ...[
                    Text(
                      document['titleNote'],
                    ),
                    Text(
                      document['descriptionNote'],
                    ),
                  ]
                ],
              ),
            );
          }),
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

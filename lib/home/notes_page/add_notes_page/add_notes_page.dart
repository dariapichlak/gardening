import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

var titleNote = '';
var descriptionNote = '';


class _AddNotesPageState extends State<AddNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Title'),
              onChanged: ((newValue) {
                setState(() {
                  titleNote = newValue;
                });
              }),
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Description'),
              onChanged: ((newValue) {
                setState(() {
                  descriptionNote = newValue;
                });
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.save),
        label: const Text('Save'),
        onPressed: () {
          FirebaseFirestore.instance.collection('notes').add({
            'descriptionNote': descriptionNote,
            'titleNote': titleNote,
          });
        },
      ),
    );
  }
}

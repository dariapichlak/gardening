import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardening/models/note_model.dart';

class NotesRepository {
  Stream<List<NoteModel>> getNotesStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return NoteModel(
          titleNote: document['titleNote'],
          id: document.id,
          value: document['value'],
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .doc(id)
        .delete();
  }

  Future<void> checked({required String id, required bool? value}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .doc(id)
        .update({
      'value': value,
    });
  }

  Future<void> add(String titleNote) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('notes')
        .add({
      'titleNote': titleNote,
      'value': false,
    });
  }
}

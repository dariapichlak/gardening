import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/models/note_model.dart';

class NotesRepository {
  Stream<List<NoteModel>> getNotesStream() {
    return FirebaseFirestore.instance
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
    return FirebaseFirestore.instance.collection('notes').doc(id).delete();
  }

  Future<void> checked({required String id, required bool? value}) async {
    return FirebaseFirestore.instance.collection('notes').doc(id).update({
      'value': value,
    });
  }

  Future<void> add(String titleNote) {
    return FirebaseFirestore.instance.collection('notes').add({
      'titleNote': titleNote,
      'value': false,
    });
  }
}

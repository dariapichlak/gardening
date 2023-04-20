import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardening/models/all_model.dart';

class AllRepository {
  Stream<List<AllModel>> getAllStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return AllModel(
          plantName: document['plantName'],
          id: document.id,
          releaseDate: (document['releaseDate'] as Timestamp).toDate(),
          imageURL: document['imageURL'],
          value: false,
          titleNote: '',
        );
      }).toList();
    });
  }

  Future<void> deleteAll() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance.collection('users').doc().delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardening/models/plant_model.dart';

class PlantsRepository {
  Stream<List<PlantModel>> getPlantsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('plants')
        .orderBy('releaseDate')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return PlantModel(
          plantName: document['plantName'],
          id: document.id,
          releaseDate: (document['releaseDate'] as Timestamp).toDate(),
          imageURL: document['imageURL'],
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
        .collection('plants')
        .doc(id)
        .delete();
  }

  Future<PlantModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('plants')
        .doc(id)
        .get();
    return PlantModel(
      plantName: document['plantName'],
      id: document.id,
      releaseDate: (document['releaseDate'] as Timestamp).toDate(),
      imageURL: document['imageURL'],
    );
  }

  Future<void> add(
    String plantName,
    DateTime releaseDate,
    String imageURL,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('plants')
        .add({
      'plantName': plantName,
      'releaseDate': releaseDate,
      'imageURL': imageURL,
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gardening/models/plant_model.dart';

class PlantsRepository {
  Stream<List<PlantModel>> getPlantsStream() {
    return FirebaseFirestore.instance
        .collection('plants')
        .orderBy('releaseDate')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return PlantModel(
          plantName: document['plantName'],
          id: document.id,
          releaseDate: (document['releaseDate'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance.collection('plants').doc(id).delete();
  }

  Future<void> add(
    String plantName,
    DateTime releaseDate,
  ) async {
    await FirebaseFirestore.instance.collection('plants').add({
      'plantName': plantName,
      'releaseDate': releaseDate,
    });
  }
}

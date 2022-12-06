import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'add_plant_page_state.dart';

class AddPlantPageCubit extends Cubit<AddPlantPageState> {
  AddPlantPageCubit() : super(const AddPlantPageState());

  Future<void> add(
    String plantName, DateTime releaseDate,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('plants').add({
        'plantName': plantName,
        'releaseDate' : releaseDate,
      });
      emit(const AddPlantPageState(save: true));
    } catch (error) {
      emit(AddPlantPageState(errorMessage: error.toString()));
    }
  }
}

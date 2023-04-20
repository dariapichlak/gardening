import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gardening/repositories/plants_repository.dart';

part 'add_plant_page_state.dart';

class AddPlantPageCubit extends Cubit<AddPlantPageState> {
  AddPlantPageCubit(this._plantsRepository) : super(const AddPlantPageState());

  final PlantsRepository _plantsRepository;

  Future<void> add(
    String plantName,
    String temp,
    String sun,
    String water,
    DateTime releaseDate,
    String imageURL,
  ) async {
    try {
      await _plantsRepository.add(
        plantName,
        temp,
        sun,
        water,
        releaseDate,
        imageURL,
      );
      emit(const AddPlantPageState(save: true));
    } catch (error) {
      emit(AddPlantPageState(errorMessage: error.toString()));
    }
  }
}

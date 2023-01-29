import 'package:bloc/bloc.dart';
import 'package:gardening/repositories/plants_repository.dart';

part 'add_plant_page_state.dart';

class AddPlantPageCubit extends Cubit<AddPlantPageState> {
  AddPlantPageCubit(this._plantsRepository) : super(const AddPlantPageState());

  final PlantsRepository _plantsRepository;

  Future<void> add(
    String plantName,
    DateTime releaseDate,
    String imageUrl,
  ) async {
    try {
      await _plantsRepository.add(
        plantName,
        releaseDate,
        imageUrl,
      );
      emit(const AddPlantPageState(save: true));
    } catch (error) {
      emit(AddPlantPageState(errorMessage: error.toString()));
    }
  }
}

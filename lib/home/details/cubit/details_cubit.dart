import 'package:bloc/bloc.dart';
import 'package:gardening/models/plant_model.dart';
import 'package:gardening/repositories/plants_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._plantsRepository)
      : super(DetailsState(
          plantModel: null,
          errorMessage: '',
          isLoading: false,
        ));

  final PlantsRepository _plantsRepository;

  Future<void> getPlantWithID(String id) async {
    final plantModel = await _plantsRepository.get(id: id);
    emit(DetailsState(
      plantModel: plantModel,
      errorMessage: '',
      isLoading: false,
    ));
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _plantsRepository.delete(id: documentID);
    } catch (error) {
      emit(
        DetailsState(
          errorMessage: error.toString(),
          isLoading: false,
          plantModel: null,
        ),
      );
    }
  }
}

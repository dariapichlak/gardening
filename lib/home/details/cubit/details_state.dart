part of 'details_cubit.dart';

class DetailsState {
  final PlantModel? plantModel;
  final bool isLoading;
  final String errorMessage;

  DetailsState({
    required this.plantModel,
    required this.errorMessage,
    required this.isLoading,
  });
}

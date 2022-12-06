part of 'add_plant_page_cubit.dart';

@immutable
class AddPlantPageState {
  final bool save;
  final String errorMessage;

  const AddPlantPageState({
    this.save = false,
    this.errorMessage = '',
  });
}

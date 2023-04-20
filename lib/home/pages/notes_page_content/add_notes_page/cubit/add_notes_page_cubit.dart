import 'package:bloc/bloc.dart';
import 'package:gardening/repositories/notes_repository.dart';
import 'package:meta/meta.dart';

part 'add_notes_page_state.dart';

class AddNotesPageContentCubit extends Cubit<AddNotesPageContentState> {
  AddNotesPageContentCubit(this._notesRepository)
      : super(const AddNotesPageContentState());

  final NotesRepository _notesRepository;

  Future<void> add(String titleNote) async {
    try {
      await _notesRepository.add(titleNote);
      emit(const AddNotesPageContentState(save: true));
    } catch (error) {
      emit(AddNotesPageContentState(errorMessage: error.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:gardening/home/notes_page/add_notes_page/add_notes_page.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'add_notes_page_state.dart';

class AddNotesPageCubit extends Cubit<AddNotesPageState> {
  AddNotesPageCubit() : super(const AddNotesPageState());

  Future<void> add(String titleNote) async {
    try {
      await FirebaseFirestore.instance.collection('notes').add({
        'titleNote': titleNote,
        'value': false,
      });
      emit(const AddNotesPageState(save: true));
    } catch (error) {
      emit(AddNotesPageState(errorMessage: error.toString()));
    }
  }
}

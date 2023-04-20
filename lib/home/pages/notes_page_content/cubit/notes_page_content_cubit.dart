import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gardening/models/note_model.dart';
import 'package:gardening/repositories/notes_repository.dart';
part 'notes_page_content_state.dart';

class NotesPageContentCubit extends Cubit<NotesPageContentState> {
  NotesPageContentCubit(this._notesRepository)
      : super(const NotesPageContentState(
          documents: [],
          isLoading: false,
          errorMessage: '',
          value: false,
        ));

  final NotesRepository _notesRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const NotesPageContentState(
        documents: [],
        errorMessage: '',
        isLoading: true,
        value: false,
      ),
    );

    _streamSubscription = _notesRepository.getNotesStream().listen((data) {
      emit(
        NotesPageContentState(
          documents: data,
          errorMessage: '',
          isLoading: false,
          value: false,
        ),
      );
    })
      ..onError(
        (error) {
          emit(
            NotesPageContentState(
              documents: const [],
              errorMessage: error.toString(),
              isLoading: false,
              value: false,
            ),
          );
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _notesRepository.delete(id: documentID);
    } catch (error) {
      emit(
        NotesPageContentState(
          errorMessage: error.toString(),
          isLoading: false,
          documents: const [],
          value: false,
        ),
      );
      start();
    }
  }

  Future<void> checked(
      {required String documentID, required bool? value}) async {
    try {
      await _notesRepository.checked(id: documentID, value: value);
    } catch (error) {
      emit(
        NotesPageContentState(
          value: false,
          documents: const [],
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

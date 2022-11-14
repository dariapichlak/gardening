import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'notes_page_state.dart';

class NotesPageCubit extends Cubit<NotesPageState> {
  NotesPageCubit()
      : super(const NotesPageState(
          documents: [],
          isLoading: false,
          errorMessage: '',
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const NotesPageState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('notes')
        .snapshots()
        .listen((data) {
      emit(
        NotesPageState(
          documents: data.docs,
          errorMessage: '',
          isLoading: false,
        ),
      );
    })
      ..onError(
        (error) {
          emit(
            NotesPageState(
              documents: const [],
              errorMessage: error.toString(),
              isLoading: false,
            ),
          );
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        NotesPageState(
          errorMessage: error.toString(),
          isLoading: false,
          documents: const [],
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

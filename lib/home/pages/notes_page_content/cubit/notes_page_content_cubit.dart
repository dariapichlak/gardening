import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'notes_page_content_state.dart';

class NotesPageContentCubit extends Cubit<NotesPageContentState> {
  NotesPageContentCubit()
      : super(const NotesPageContentState(
          documents: [],
          isLoading: false,
          errorMessage: '',
          value: false,
        ));

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

    _streamSubscription = FirebaseFirestore.instance
        .collection('notes')
        .snapshots()
        .listen((data) {
      emit(
        NotesPageContentState(
          documents: data.docs,
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
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(documentID)
          .delete();
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
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(documentID)
          .update({
        'value': value,
      });
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
